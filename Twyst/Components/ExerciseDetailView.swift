//
//  ExerciseDetailView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let duration: String
    let difficulty: String
    let category: String
    
    @State private var isFavorited: Bool = false
    @State private var bandanasVerified: Bool = false
    @State private var isVerifying: Bool = false
    @State private var showActiveWorkout: Bool = false
    
    // Cached random mock data
    let minBandanas: Int
    let caloriesBurned: Int
    let xpReward: Int
    
    // Cached previous performance data
    let previousAccuracy: Int
    let previousTime: Int
    let bestAccuracy: Int
    let timesCompleted: Int
    
    let description = "This exercise is designed to target specific muscle groups and improve overall fitness. Perfect for building strength and endurance while maintaining proper form throughout the movement."
    
    let equipment: [String]
    let musclesWorked: [String]
    let bandanaPositions: [(String, String)]
    let steps: [String]
    let tips: [String]
    
    init(title: String, duration: String, difficulty: String, category: String) {
        self.title = title
        self.duration = duration
        self.difficulty = difficulty
        self.category = category
        
        // Initialize random data once
        self.minBandanas = Int.random(in: 1...5)
        self.caloriesBurned = Int.random(in: 50...500)
        self.xpReward = Int.random(in: 10...100)
        
        self.previousAccuracy = Int.random(in: 60...98)
        self.previousTime = Int.random(in: 5...30)
        self.bestAccuracy = Int.random(in: 85...100)
        self.timesCompleted = Int.random(in: 0...50)
        
        // Cache equipment
        let allEquipment = ["No Equipment", "Dumbbells", "Resistance Bands", "Yoga Mat", "Kettlebell", "Pull-up Bar", "Bench", "Medicine Ball"]
        let equipmentCount = Int.random(in: 1...3)
        self.equipment = Array(allEquipment.shuffled().prefix(equipmentCount))
        
        // Cache muscles
        let allMuscles = ["Core", "Arms", "Legs", "Back", "Chest", "Shoulders", "Glutes", "Calves", "Abs"]
        let muscleCount = Int.random(in: 2...4)
        self.musclesWorked = Array(allMuscles.shuffled().prefix(muscleCount))
        
        // Cache bandana positions
        let positions = [
            ("Left Wrist", "For tracking arm movement and rotation"),
            ("Right Wrist", "For tracking arm movement and rotation"),
            ("Left Ankle", "For tracking leg movement and balance"),
            ("Right Ankle", "For tracking leg movement and balance"),
            ("Waist", "For tracking core engagement and posture"),
            ("Upper Arm", "For tracking bicep and tricep engagement"),
            ("Thigh", "For tracking leg extension and flexion")
        ]
        self.bandanaPositions = Array(positions.shuffled().prefix(self.minBandanas))
        
        // Cache steps
        self.steps = [
            "Begin in the starting position with proper posture and alignment",
            "Engage your core and maintain a neutral spine throughout the movement",
            "Execute the movement slowly and with control, focusing on form",
            "Breathe steadily - exhale during exertion, inhale during recovery",
            "Complete the specified number of repetitions or hold time",
            "Rest briefly between sets and maintain hydration"
        ]
        
        // Cache tips
        let allTips = [
            "Keep your movements controlled and deliberate",
            "Focus on quality over quantity",
            "Listen to your body and rest when needed",
            "Maintain proper breathing throughout",
            "Warm up before and cool down after",
            "Stay hydrated during your workout",
            "Use proper form to prevent injury"
        ]
        self.tips = Array(allTips.shuffled().prefix(3))
    }
    
    var difficultyColor: Color {
        switch difficulty {
        case "Beginner": return .green
        case "Intermediate": return .orange
        case "Advanced": return .customRed
        default: return .gray
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header with back button
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black.opacity(0.6))
                            Text("Back")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isFavorited.toggle()
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundStyle(isFavorited ? .customRed : .black.opacity(0.4))
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 12)
                .background(Color.white)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title and category
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.DIN(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    HStack(spacing: 12) {
                        // Category badge
                        Text(category)
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.lightBlue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.lightBlue.opacity(0.15))
                            .cornerRadius(12)
                        
                        // Difficulty badge
                        Text(difficulty)
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(difficultyColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(difficultyColor.opacity(0.15))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Quick stats
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(.lightBlue)
                            Text(duration)
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Text("Duration")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.1), lineWidth: 2)
                    )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(.orange)
                            Text("\(caloriesBurned)")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Text("Calories")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.1), lineWidth: 2)
                    )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 12))
                                .foregroundStyle(.goldYellow)
                            Text("\(xpReward)")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Text("XP Reward")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.1), lineWidth: 2)
                    )
                }
                .padding(.horizontal)
                
                // Bandana requirement
                VStack(alignment: .leading, spacing: 8) {
                    Text("Requirement")
                        .font(.DIN(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            ForEach(0..<minBandanas, id: \.self) { _ in
                                Image("bandana-sm")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                            }
                        }
                        
                        Text("Minimum \(minBandanas) Twyst \(minBandanas == 1 ? "bandana" : "bandanas") required")
                            .font(.DIN())
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.1), lineWidth: 2)
                    )
                }
                .padding(.horizontal)
                
                // Bandana Positioning
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        Image("bandana-sm")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                        Text("Bandana Positioning")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    
                    Text("Place your Twyst bandanas on the following positions:")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                    
                    VStack(spacing: 10) {
                        ForEach(Array(bandanaPositions.enumerated()), id: \.offset) { index, position in
                            HStack(alignment: .top, spacing: 12) {
                                Image("bandana-sm")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(position.0)
                                        .font(.DIN(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Text(position.1)
                                        .font(.DIN(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightGray, lineWidth: 1)
                            )
                        }
                    }
                    
                    // Verification Button or Success Message
                    if !bandanasVerified {
                        Button(action: {
                            isVerifying = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isVerifying = false
                                bandanasVerified = true
                            }
                        }) {
                            HStack {
                                if isVerifying {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    Text("Verifying...")
                                        .font(.DIN(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                } else {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 18))
                                    Text("Verify Bandana Placement")
                                        .font(.DIN(size: 16))
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.lightBlue)
                            .cornerRadius(12)
                        }
                        .disabled(isVerifying)
                        .padding(.top, 8)
                    } else {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.green)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Bandanas Verified! ✓")
                                    .font(.DIN(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                                
                                Text("All bandanas are correctly positioned")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(.green.opacity(0.1))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.green.opacity(0.3), lineWidth: 2)
                        )
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
                
                // Previous Performance
                if timesCompleted > 0 {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 6) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 18))
                                .foregroundStyle(.lightBlue)
                            Text("Your Performance")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                // Last accuracy
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Last Accuracy")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(previousAccuracy)%")
                                            .font(.DIN(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Image(systemName: previousAccuracy >= 85 ? "arrow.up.circle.fill" : "arrow.right.circle.fill")
                                            .foregroundStyle(previousAccuracy >= 85 ? .green : .orange)
                                            .font(.system(size: 20))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.1), lineWidth: 2)
                                )
                                
                                // Best accuracy
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Best Accuracy")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(bestAccuracy)%")
                                            .font(.DIN(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.goldYellow)
                                        
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.goldYellow)
                                            .font(.system(size: 20))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.1), lineWidth: 2)
                                )
                            }
                            
                            HStack(spacing: 12) {
                                // Last time
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Last Duration")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Image(systemName: "clock.fill")
                                            .foregroundStyle(.lightBlue)
                                            .font(.system(size: 16))
                                        Text("\(previousTime) min")
                                            .font(.DIN(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.1), lineWidth: 2)
                                )
                                
                                // Times completed
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Times Completed")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.green)
                                            .font(.system(size: 16))
                                        Text("\(timesCompleted)")
                                            .font(.DIN(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.1), lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding()
                    .background(.lightBlue.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.DIN(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text(description)
                        .font(.DIN())
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.6))
                        .lineSpacing(4)
                }
                .padding(.horizontal)
                
                // Equipment needed
                VStack(alignment: .leading, spacing: 8) {
                    Text("Equipment")
                        .font(.DIN(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    FlowLayout(spacing: 8) {
                        ForEach(equipment, id: \.self) { item in
                            HStack(spacing: 6) {
                                Image(systemName: item == "No Equipment" ? "checkmark.circle.fill" : "dumbbell.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.lightBlue)
                                Text(item)
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.lightGray, lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Muscles worked
                VStack(alignment: .leading, spacing: 8) {
                    Text("Muscles Worked")
                        .font(.DIN(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    FlowLayout(spacing: 8) {
                        ForEach(musclesWorked, id: \.self) { muscle in
                            Text(muscle)
                                .font(.DIN(size: 14))
                                .fontWeight(.bold)
                                .foregroundStyle(.goldYellow)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.goldYellow.opacity(0.15))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Steps
                VStack(alignment: .leading, spacing: 12) {
                    Text("How to Perform")
                        .font(.DIN(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(.lightBlue)
                                .clipShape(Circle())
                            
                            Text(step)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                                .lineSpacing(4)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Tips
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(.goldYellow)
                        Text("Pro Tips")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    
                    ForEach(tips, id: \.self) { tip in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.green)
                            
                            Text(tip)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                        }
                    }
                }
                .padding()
                .background(.goldYellow.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Start button
                PrimitiveButton(content: "Start Exercise", type: .primary) {
                    showActiveWorkout = true
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showActiveWorkout) {
            ActiveWorkoutView(
                exerciseName: title,
                difficulty: difficulty,
                category: category
            )
        }
    }
}

// Simple flow layout for tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                
                frames.append(CGRect(x: currentX, y: currentY, width: size.width, height: size.height))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

#Preview {
    ExerciseDetailView(
        title: "Push-ups",
        duration: "10 min",
        difficulty: "Beginner",
        category: "Strength"
    )
}

