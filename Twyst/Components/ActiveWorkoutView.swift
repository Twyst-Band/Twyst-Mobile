//
//  ActiveWorkoutView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI
import Charts

struct ActiveWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    let exerciseName: String
    let difficulty: String
    let category: String
    let targetReps: Int
    let targetSets: Int
    
    // Workout state
    @State private var workoutState: WorkoutState = .countdown
    @State private var countdownValue: Int = 3
    @State private var currentSet: Int = 1
    @State private var currentRep: Int = 0
    @State private var elapsedTime: Int = 0
    @State private var isPaused: Bool = false
    @State private var showExitConfirmation: Bool = false
    
    // Performance metrics (live updating)
    @State private var currentAccuracy: Int = 0
    @State private var averageAccuracy: Int = 0
    @State private var heartRate: Int = 0
    @State private var caloriesBurned: Int = 0
    @State private var formQuality: Double = 0.0
    
    // Bandana sensor data (live)
    @State private var leftWristAngle: Double = 0
    @State private var rightWristAngle: Double = 0
    @State private var waistTilt: Double = 0
    @State private var leftAnklePosition: Double = 0
    
    // Historical data for comparison
    let previousBestAccuracy: Int
    let previousBestTime: Int
    let previousAvgHeartRate: Int
    
    // Timer
    @State private var timer: Timer?
    @State private var sensorTimer: Timer?
    
    // Auto-rep feature
    @State private var autoRepEnabled: Bool = true
    @State private var autoRepSpeed: Double = 1.0 // seconds per rep
    @State private var autoRepTimer: Timer?
    @State private var showAutoRepSettings: Bool = false
    
    // Real-time graph data
    @State private var accuracyHistory: [AccuracyPoint] = []
    @State private var heartRateHistory: [HeartRatePoint] = []
    
    // Completion
    @State private var showCompletionScreen: Bool = false
    @State private var finalStats: WorkoutStats?
    
    init(exerciseName: String, difficulty: String, category: String) {
        self.exerciseName = exerciseName
        self.difficulty = difficulty
        self.category = category
        
        // Set targets based on difficulty
        switch difficulty {
        case "Beginner":
            self.targetReps = Int.random(in: 8...12)
            self.targetSets = Int.random(in: 2...3)
        case "Intermediate":
            self.targetReps = Int.random(in: 12...15)
            self.targetSets = Int.random(in: 3...4)
        case "Advanced":
            self.targetReps = Int.random(in: 15...20)
            self.targetSets = Int.random(in: 4...5)
        default:
            self.targetReps = 10
            self.targetSets = 3
        }
        
        // Previous performance (cached)
        self.previousBestAccuracy = Int.random(in: 75...95)
        self.previousBestTime = Int.random(in: 300...600)
        self.previousAvgHeartRate = Int.random(in: 120...150)
    }
    
    var formattedTime: String {
        let minutes = elapsedTime / 60
        let seconds = elapsedTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var progressPercentage: Double {
        let totalReps = Double(targetReps * targetSets)
        let completedReps = Double((currentSet - 1) * targetReps + currentRep)
        return min(completedReps / totalReps, 1.0)
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if workoutState == .countdown {
                countdownView
            } else if showCompletionScreen, let stats = finalStats {
                CompletionView(
                    stats: stats,
                    exerciseName: exerciseName,
                    onDismiss: { dismiss() }
                )
            } else {
                workoutView
            }
        }
        .onAppear {
            startCountdown()
        }
        .onDisappear {
            stopTimers()
        }
    }
    
    // MARK: - Countdown View
    var countdownView: some View {
        VStack(spacing: 40) {
            Text("Get Ready!")
                .font(.DIN(size: 32))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.8))
            
            Text("\(countdownValue)")
                .font(.system(size: 120, weight: .bold, design: .rounded))
                .foregroundStyle(.lightBlue)
                .animation(.spring(response: 0.3), value: countdownValue)
            
            Text(exerciseName)
                .font(.DIN(size: 24))
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.6))
        }
    }
    
    // MARK: - Main Workout View
    var workoutView: some View {
        VStack(spacing: 0) {
            // Header with timer and exit
            headerView
            
            ScrollView {
                VStack(spacing: 20) {
                    // Main rep counter and progress
                    repCounterView
                    
                    // Current accuracy and form quality
                    metricsCardsView
                    
                    // Live sensor data visualization
                    sensorDataView
                    
                    // Real-time graphs
                    performanceGraphsView
                    
                    // Comparison with previous best
                    comparisonView
                    
                    // Control buttons
                    controlButtonsView
                    
                    Spacer()
                        .frame(height: 20)
                }
            }
        }
        .alert("End Workout?", isPresented: $showExitConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("End Workout", role: .destructive) {
                completeWorkout()
            }
        } message: {
            Text("Are you sure you want to end this workout session?")
        }
        .sheet(isPresented: $showAutoRepSettings) {
            AutoRepSettingsView(
                autoRepEnabled: $autoRepEnabled,
                autoRepSpeed: $autoRepSpeed
            )
            .presentationDetents([.height(320)])
            .onDisappear {
                // Force check when settings close - workaround for state timing
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if autoRepEnabled && autoRepTimer == nil {
                        startAutoRep()
                    }
                }
            }
        }
        .onChange(of: autoRepEnabled) { enabled in
            if enabled {
                stopAutoRep() // Stop any existing timer first
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    startAutoRep()
                }
            } else {
                stopAutoRep()
            }
        }
        .onChange(of: autoRepSpeed) { _ in
            if autoRepEnabled {
                // Restart with new speed
                stopAutoRep()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    startAutoRep()
                }
            }
        }
    }
    
    // MARK: - Header View
    var headerView: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: {
                    showExitConfirmation = true
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(8)
                }
                
                Spacer()
                
                // Timer
                VStack(spacing: 2) {
                    Text(formattedTime)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.8))
                    
                    Text("Elapsed Time")
                        .font(.DIN(size: 12))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
                
                Spacer()
                
                // Heart rate
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.customRed)
                    
                    Text("\(heartRate)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("BPM")
                        .font(.DIN(size: 10))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.customRed.opacity(0.1))
                .cornerRadius(20)
                
                // Auto-rep settings button
                Button(action: {
                    showAutoRepSettings = true
                }) {
                    Image(systemName: autoRepEnabled ? "bolt.fill" : "bolt.slash.fill")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(autoRepEnabled ? .goldYellow : .black.opacity(0.4))
                        .padding(8)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.lightGray.opacity(0.2))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(.lightBlue)
                        .frame(width: geo.size.width * progressPercentage, height: 4)
                        .animation(.linear(duration: 0.3), value: progressPercentage)
                }
            }
            .frame(height: 4)
            .padding(.horizontal)
        }
        .padding(.bottom, 16)
        .background(.white)
        .overlay(
            Rectangle()
                .fill(.lightGray.opacity(0.3))
                .frame(height: 1)
                .offset(y: 0),
            alignment: .bottom
        )
    }
    
    // MARK: - Rep Counter View
    var repCounterView: some View {
        VStack(spacing: 16) {
            // Set indicator
            HStack(spacing: 8) {
                ForEach(1...targetSets, id: \.self) { set in
                    Circle()
                        .fill(set <= currentSet ? .lightBlue : .lightGray.opacity(0.3))
                        .frame(width: 12, height: 12)
                }
            }
            
            Text("Set \(currentSet) of \(targetSets)")
                .font(.DIN(size: 16))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.6))
            
            // Large rep counter
            ZStack {
                Circle()
                    .stroke(.lightGray.opacity(0.2), lineWidth: 20)
                    .frame(width: 220, height: 220)
                
                Circle()
                    .trim(from: 0, to: Double(currentRep) / Double(targetReps))
                    .stroke(.lightBlue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .frame(width: 220, height: 220)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.5), value: currentRep)
                
                VStack(spacing: 8) {
                    Text("\(currentRep)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundStyle(.lightBlue)
                    
                    Text("/ \(targetReps) reps")
                        .font(.DIN(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
            
            // Quick action: Complete rep button
            Button(action: {
                completeRep()
            }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                    Text("Complete Rep")
                        .font(.DIN(size: 18))
                        .fontWeight(.bold)
                }
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.lightBlue)
                .cornerRadius(12)
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.lightGray, lineWidth: 2)
        )
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    // MARK: - Metrics Cards View
    var metricsCardsView: some View {
        HStack(spacing: 12) {
            // Current accuracy
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "target")
                        .font(.system(size: 14))
                        .foregroundStyle(.green)
                    Text("Accuracy")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.6))
                }
                
                Text("\(currentAccuracy)%")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.green)
                
                Text(formQualityText)
                    .font(.DIN(size: 12))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.green.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.green.opacity(0.3), lineWidth: 2)
            )
            
            // Calories burned
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.orange)
                    Text("Calories")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.6))
                }
                
                Text("\(caloriesBurned)")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.orange)
                
                Text("burned")
                    .font(.DIN(size: 12))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.orange.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.orange.opacity(0.3), lineWidth: 2)
            )
        }
        .padding(.horizontal)
    }
    
    var formQualityText: String {
        if currentAccuracy >= 90 { return "Perfect!" }
        else if currentAccuracy >= 75 { return "Great" }
        else if currentAccuracy >= 60 { return "Good" }
        else { return "Keep trying" }
    }
    
    // MARK: - Sensor Data View
    var sensorDataView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image("bandana-sm")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                
                Text("Live Sensor Data")
                    .font(.DIN(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Spacer()
                
                Circle()
                    .fill(.green)
                    .frame(width: 8, height: 8)
                
                Text("Connected")
                    .font(.DIN(size: 12))
                    .fontWeight(.medium)
                    .foregroundStyle(.green)
            }
            
            VStack(spacing: 12) {
                SensorBar(label: "Left Wrist", value: leftWristAngle, color: .lightBlue, unit: "°")
                SensorBar(label: "Right Wrist", value: rightWristAngle, color: .purple, unit: "°")
                SensorBar(label: "Waist Tilt", value: waistTilt, color: .orange, unit: "°")
                SensorBar(label: "Left Ankle", value: leftAnklePosition, color: .green, unit: "°")
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.lightGray, lineWidth: 2)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Performance Graphs View
    var performanceGraphsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Real-Time Performance")
                .font(.DIN(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.7))
                .padding(.horizontal)
            
            // Accuracy over time graph
            VStack(alignment: .leading, spacing: 8) {
                Text("Form Accuracy")
                    .font(.DIN(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.6))
                
                if accuracyHistory.count > 1 {
                    Chart(accuracyHistory) { point in
                        LineMark(
                            x: .value("Time", point.timestamp),
                            y: .value("Accuracy", point.accuracy)
                        )
                        .foregroundStyle(.green)
                        .interpolationMethod(.catmullRom)
                        
                        AreaMark(
                            x: .value("Time", point.timestamp),
                            y: .value("Accuracy", point.accuracy)
                        )
                        .foregroundStyle(.green.opacity(0.2))
                        .interpolationMethod(.catmullRom)
                    }
                    .chartYScale(domain: 0...100)
                    .chartYAxis {
                        AxisMarks(position: .leading, values: [0, 50, 100])
                    }
                    .chartXAxis(.hidden)
                    .frame(height: 120)
                } else {
                    Rectangle()
                        .fill(.lightGray.opacity(0.1))
                        .frame(height: 120)
                        .overlay(
                            Text("Collecting data...")
                                .font(.DIN(size: 14))
                                .foregroundStyle(.black.opacity(0.4))
                        )
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.lightGray, lineWidth: 2)
            )
            
            // Heart rate graph
            VStack(alignment: .leading, spacing: 8) {
                Text("Heart Rate")
                    .font(.DIN(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.6))
                
                if heartRateHistory.count > 1 {
                    Chart(heartRateHistory) { point in
                        LineMark(
                            x: .value("Time", point.timestamp),
                            y: .value("BPM", point.bpm)
                        )
                        .foregroundStyle(.customRed)
                        .interpolationMethod(.catmullRom)
                        
                        AreaMark(
                            x: .value("Time", point.timestamp),
                            y: .value("BPM", point.bpm)
                        )
                        .foregroundStyle(.customRed.opacity(0.2))
                        .interpolationMethod(.catmullRom)
                    }
                    .chartYScale(domain: 60...180)
                    .chartYAxis {
                        AxisMarks(position: .leading, values: [60, 120, 180])
                    }
                    .chartXAxis(.hidden)
                    .frame(height: 120)
                } else {
                    Rectangle()
                        .fill(.lightGray.opacity(0.1))
                        .frame(height: 120)
                        .overlay(
                            Text("Collecting data...")
                                .font(.DIN(size: 14))
                                .foregroundStyle(.black.opacity(0.4))
                        )
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.lightGray, lineWidth: 2)
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - Comparison View
    var comparisonView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("vs. Personal Best")
                .font(.DIN(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.7))
            
            VStack(spacing: 12) {
                ComparisonRow(
                    label: "Accuracy",
                    current: "\(averageAccuracy)%",
                    previous: "\(previousBestAccuracy)%",
                    isImproving: averageAccuracy >= previousBestAccuracy
                )
                
                ComparisonRow(
                    label: "Time",
                    current: formattedTime,
                    previous: formatTime(previousBestTime),
                    isImproving: elapsedTime <= previousBestTime
                )
                
                ComparisonRow(
                    label: "Avg Heart Rate",
                    current: "\(heartRate) BPM",
                    previous: "\(previousAvgHeartRate) BPM",
                    isImproving: heartRate <= previousAvgHeartRate
                )
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.lightGray, lineWidth: 2)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Control Buttons View
    var controlButtonsView: some View {
        HStack(spacing: 12) {
            // Pause/Resume button
            Button(action: {
                togglePause()
            }) {
                HStack {
                    Image(systemName: isPaused ? "play.fill" : "pause.fill")
                        .font(.system(size: 18))
                    Text(isPaused ? "Resume" : "Pause")
                        .font(.DIN(size: 16))
                        .fontWeight(.bold)
                }
                .foregroundStyle(.lightBlue)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.lightBlue, lineWidth: 2)
                )
            }
            
            // Complete workout button
            Button(action: {
                completeWorkout()
            }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))
                    Text("Finish")
                        .font(.DIN(size: 16))
                        .fontWeight(.bold)
                }
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.green)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Helper Functions
    func startCountdown() {
        let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
            if self.countdownValue > 1 {
                self.countdownValue -= 1
            } else {
                timer.invalidate()
                self.workoutState = .active
                self.startWorkout()
            }
        }
        RunLoop.current.add(countdownTimer, forMode: .common)
    }
    
    func startWorkout() {
        // Start main timer (continues during scroll)
        let mainTimer = Timer(timeInterval: 1.0, repeats: true) { _ in
            if !self.isPaused {
                self.elapsedTime += 1
                
                // Update metrics periodically
                if self.elapsedTime % 2 == 0 {
                    self.updateMetrics()
                }
            }
        }
        RunLoop.current.add(mainTimer, forMode: .common)
        timer = mainTimer
        
        // Start sensor data timer (faster updates, continues during scroll)
        let sensorUpdateTimer = Timer(timeInterval: 0.1, repeats: true) { _ in
            if !self.isPaused {
                self.updateSensorData()
            }
        }
        RunLoop.current.add(sensorUpdateTimer, forMode: .common)
        sensorTimer = sensorUpdateTimer
        
        // Initialize starting values
        heartRate = Int.random(in: 80...100)
        currentAccuracy = Int.random(in: 70...85)
        
        // Start auto-rep if enabled
        if autoRepEnabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.startAutoRep()
            }
        }
    }
    
    func stopTimers() {
        timer?.invalidate()
        sensorTimer?.invalidate()
        autoRepTimer?.invalidate()
    }
    
    func startAutoRep() {
        // Stop existing auto-rep timer if any
        autoRepTimer?.invalidate()
        
        // Start new auto-rep timer
        let repTimer = Timer(timeInterval: autoRepSpeed, repeats: true) { _ in
            if !self.isPaused && self.workoutState == .active {
                self.completeRep()
            }
        }
        RunLoop.current.add(repTimer, forMode: .common)
        autoRepTimer = repTimer
    }
    
    func stopAutoRep() {
        autoRepTimer?.invalidate()
        autoRepTimer = nil
    }
    
    func updateMetrics() {
        // Simulate improving accuracy over time
        if currentAccuracy < 95 {
            currentAccuracy = min(currentAccuracy + Int.random(in: 0...3), 95)
        }
        
        // Update average accuracy
        averageAccuracy = (averageAccuracy * (elapsedTime - 2) + currentAccuracy * 2) / elapsedTime
        
        // Update heart rate (simulate workout intensity)
        let targetHR = 120 + Int(Double(currentSet) * 10.0)
        if heartRate < targetHR {
            heartRate = min(heartRate + Int.random(in: 1...3), targetHR)
        } else {
            heartRate = max(heartRate - Int.random(in: 0...2), targetHR)
        }
        
        // Update calories (roughly 5-8 per minute)
        caloriesBurned = elapsedTime * Int.random(in: 5...8) / 60
        
        // Add to history for graphs
        accuracyHistory.append(AccuracyPoint(timestamp: elapsedTime, accuracy: currentAccuracy))
        if accuracyHistory.count > 30 {
            accuracyHistory.removeFirst()
        }
        
        heartRateHistory.append(HeartRatePoint(timestamp: elapsedTime, bpm: heartRate))
        if heartRateHistory.count > 30 {
            heartRateHistory.removeFirst()
        }
    }
    
    func updateSensorData() {
        // Simulate live sensor readings with smooth variations
        leftWristAngle = 45 + sin(Double(elapsedTime) * 2) * 30 + Double.random(in: -5...5)
        rightWristAngle = 50 + cos(Double(elapsedTime) * 2.2) * 28 + Double.random(in: -5...5)
        waistTilt = 15 + sin(Double(elapsedTime) * 1.5) * 12 + Double.random(in: -3...3)
        leftAnklePosition = 30 + cos(Double(elapsedTime) * 1.8) * 25 + Double.random(in: -4...4)
        
        // Update form quality based on sensor alignment
        formQuality = Double.random(in: 0.7...0.95)
    }
    
    func completeRep() {
        if currentRep < targetReps {
            currentRep += 1
            
            // Add haptic feedback (would work on real device)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        } else {
            // Move to next set
            if currentSet < targetSets {
                currentSet += 1
                currentRep = 0
            } else {
                // Workout complete
                completeWorkout()
            }
        }
    }
    
    func togglePause() {
        isPaused.toggle()
    }
    
    func completeWorkout() {
        stopTimers()
        
        // Calculate final stats
        let stats = WorkoutStats(
            duration: elapsedTime,
            totalReps: (currentSet - 1) * targetReps + currentRep,
            averageAccuracy: averageAccuracy,
            caloriesBurned: caloriesBurned,
            averageHeartRate: heartRate,
            xpEarned: calculateXP(),
            improvedFromBest: averageAccuracy >= previousBestAccuracy
        )
        
        finalStats = stats
        showCompletionScreen = true
    }
    
    func calculateXP() -> Int {
        let baseXP = 50
        let accuracyBonus = averageAccuracy / 2
        let completionBonus = currentSet == targetSets ? 30 : 0
        return baseXP + accuracyBonus + completionBonus
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

// MARK: - Supporting Views

struct SensorBar: View {
    let label: String
    let value: Double
    let color: Color
    let unit: String
    
    var normalizedValue: Double {
        min(max(value / 90.0, 0), 1.0) // Normalize to 0-1 range (0-90 degrees)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .font(.DIN(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.6))
                
                Spacer()
                
                Text(String(format: "%.1f%@", value, unit))
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(color.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: geo.size.width * normalizedValue, height: 8)
                        .cornerRadius(4)
                        .animation(.linear(duration: 0.1), value: normalizedValue)
                }
            }
            .frame(height: 8)
        }
    }
}

struct ComparisonRow: View {
    let label: String
    let current: String
    let previous: String
    let isImproving: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(.DIN(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.6))
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 4) {
                    Text(current)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.black.opacity(0.8))
                    
                    Image(systemName: isImproving ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(isImproving ? .green : .orange)
                }
                
                Text("Best: \(previous)")
                    .font(.DIN(size: 12))
                    .foregroundStyle(.black.opacity(0.5))
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.lightGray, lineWidth: 1)
        )
    }
}

// MARK: - Completion View

struct CompletionView: View {
    let stats: WorkoutStats
    let exerciseName: String
    let onDismiss: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 40)
                
                // Success animation/icon
                ZStack {
                    Circle()
                        .fill(.green.opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.green)
                }
                
                VStack(spacing: 8) {
                    Text("Workout Complete!")
                        .font(.DIN(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.8))
                    
                    Text(exerciseName)
                        .font(.DIN(size: 20))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.6))
                }
                
                // Stats grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    StatCard(icon: "clock.fill", label: "Duration", value: formatDuration(stats.duration), color: .lightBlue)
                    StatCard(icon: "target", label: "Accuracy", value: "\(stats.averageAccuracy)%", color: .green)
                    StatCard(icon: "flame.fill", label: "Calories", value: "\(stats.caloriesBurned)", color: .orange)
                    StatCard(icon: "heart.fill", label: "Avg HR", value: "\(stats.averageHeartRate)", color: .customRed)
                    StatCard(icon: "figure.strengthtraining.traditional", label: "Reps", value: "\(stats.totalReps)", color: .purple)
                    StatCard(icon: "sparkles", label: "XP Earned", value: "+\(stats.xpEarned)", color: .goldYellow)
                }
                .padding(.horizontal)
                
                // Achievement badge if improved
                if stats.improvedFromBest {
                    HStack(spacing: 12) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.goldYellow)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("New Personal Best!")
                                .font(.DIN(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.goldYellow)
                            
                            Text("You've improved your accuracy")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(.goldYellow.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.goldYellow.opacity(0.3), lineWidth: 2)
                    )
                    .padding(.horizontal)
                }
                
                // Done button
                PrimitiveButton(content: "Done", type: .primary) {
                    onDismiss()
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
                    .frame(height: 20)
            }
        }
        .background(Color.white)
    }
    
    func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

struct StatCard: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(color)
            
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.8))
            
            Text(label)
                .font(.DIN(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.lightGray, lineWidth: 2)
        )
    }
}

// MARK: - Auto-Rep Settings View

struct AutoRepSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var autoRepEnabled: Bool
    @Binding var autoRepSpeed: Double
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("Auto-Rep Settings")
                    .font(.DIN(size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.8))
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.black.opacity(0.3))
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            VStack(spacing: 20) {
                // Enable/Disable toggle
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(autoRepEnabled ? .goldYellow : .black.opacity(0.4))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Auto-Complete Reps")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.8))
                            
                            Text("Automatically complete reps at set interval")
                                .font(.DIN(size: 12))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $autoRepEnabled)
                        .labelsHidden()
                        .tint(.lightBlue)
                        .onChange(of: autoRepEnabled) { newValue in
                            // Force state propagation
                            DispatchQueue.main.async {
                                autoRepEnabled = newValue
                            }
                        }
                }
                .padding()
                .background(.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.lightGray, lineWidth: 2)
                )
                
                // Speed slider
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Rep Speed")
                            .font(.DIN(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.8))
                        
                        Spacer()
                        
                        Text("\(String(format: "%.1f", autoRepSpeed))s")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.lightBlue)
                    }
                    
                    VStack(spacing: 8) {
                        Slider(value: $autoRepSpeed, in: 0.5...5.0, step: 0.1)
                            .tint(.lightBlue)
                            .disabled(!autoRepEnabled)
                        
                        HStack {
                            Text("Fast")
                                .font(.DIN(size: 12))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.5))
                            
                            Spacer()
                            
                            Text("Slow")
                                .font(.DIN(size: 12))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                    }
                    
                    Text("Time between each automatic rep completion")
                        .font(.DIN(size: 12))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
                .padding()
                .background(autoRepEnabled ? .white : .white.opacity(0.5))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.lightGray, lineWidth: 2)
                )
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.white)
    }
}

// MARK: - Models

enum WorkoutState {
    case countdown
    case active
    case completed
}

struct AccuracyPoint: Identifiable {
    let id = UUID()
    let timestamp: Int
    let accuracy: Int
}

struct HeartRatePoint: Identifiable {
    let id = UUID()
    let timestamp: Int
    let bpm: Int
}

struct WorkoutStats {
    let duration: Int
    let totalReps: Int
    let averageAccuracy: Int
    let caloriesBurned: Int
    let averageHeartRate: Int
    let xpEarned: Int
    let improvedFromBest: Bool
}

