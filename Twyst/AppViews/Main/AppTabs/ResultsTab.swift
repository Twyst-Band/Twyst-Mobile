//
//  ResultsTab.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI
import Charts

struct ResultsTab: View {
    @State private var selectedTimeRange: String = "Week"
    @State private var showAllChallenges: Bool = false
    @State private var showAllActivity: Bool = false
    @State private var selectedChallenge: ActiveChallenge? = nil
    
    let timeRanges = ["Week", "Month", "Year"]
    
    // Mock data for active challenges
    let activeChallenges: [ActiveChallenge] = [
        ActiveChallenge(
            name: "30-Day Transformation",
            currentDay: 12,
            totalDays: 30,
            streak: 5,
            completionRate: 85
        ),
        ActiveChallenge(
            name: "Core Crusher Challenge",
            currentDay: 8,
            totalDays: 21,
            streak: 3,
            completionRate: 92
        ),
        ActiveChallenge(
            name: "Flexibility Master",
            currentDay: 45,
            totalDays: 60,
            streak: 12,
            completionRate: 78
        )
    ]
    
    // Mock data for weekly stats
    let weeklyData: [WorkoutDay] = [
        WorkoutDay(day: "Mon", minutes: 35, calories: 280, xp: 150),
        WorkoutDay(day: "Tue", minutes: 45, calories: 350, xp: 200),
        WorkoutDay(day: "Wed", minutes: 20, calories: 160, xp: 100),
        WorkoutDay(day: "Thu", minutes: 50, calories: 420, xp: 250),
        WorkoutDay(day: "Fri", minutes: 30, calories: 240, xp: 150),
        WorkoutDay(day: "Sat", minutes: 60, calories: 480, xp: 300),
        WorkoutDay(day: "Sun", minutes: 25, calories: 200, xp: 125)
    ]
    
    // Mock data for friend activity
    let recentActivity: [FriendActivity] = [
        FriendActivity(
            friendName: "Sarah Johnson",
            friendUsername: "sarahj",
            exerciseName: "Advanced Plank",
            minutesAgo: 25,
            yourAccuracy: 94,
            friendAccuracy: 88
        ),
        FriendActivity(
            friendName: "Mike Chen",
            friendUsername: "mikechen",
            exerciseName: "HIIT Cardio Blast",
            minutesAgo: 120,
            yourAccuracy: 87,
            friendAccuracy: 91
        ),
        FriendActivity(
            friendName: "Emma Wilson",
            friendUsername: "emmaw",
            exerciseName: "Yoga Flow",
            minutesAgo: 180,
            yourAccuracy: 96,
            friendAccuracy: 92
        )
    ]
    
    // Recent achievements
    let recentBadges: [Achievement] = [
        Achievement(icon: "flame.fill", title: "10 Day Streak", color: .orange, earnedDaysAgo: 0),
        Achievement(icon: "star.fill", title: "Perfect Week", color: .goldYellow, earnedDaysAgo: 2),
        Achievement(icon: "bolt.fill", title: "100 Workouts", color: .lightBlue, earnedDaysAgo: 5)
    ]
    
    var totalWeekMinutes: Int {
        weeklyData.reduce(0) { $0 + $1.minutes }
    }
    
    var totalWeekCalories: Int {
        weeklyData.reduce(0) { $0 + $1.calories }
    }
    
    var totalWeekXP: Int {
        weeklyData.reduce(0) { $0 + $1.xp }
    }
    
    // Cached random streak value
    let currentStreak: Int = Int.random(in: 8...15)
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header
            Text("Results")
                .font(.DIN(size: 28))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 16)
                .background(.white)
                .overlay(
                    Rectangle()
                        .fill(.lightGray.opacity(0.3))
                        .frame(height: 1)
                        .offset(y: 0),
                    alignment: .bottom
                )
            
            // Scrollable Content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 8)
                    
                    // Current Streak Banner
                HStack {
                    HStack(spacing: 12) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(.orange)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(currentStreak) Day Streak")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            Text("Keep it going! 🔥")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.orange.opacity(0.8))
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                        .foregroundStyle(.black.opacity(0.3))
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange.opacity(0.15), .orange.opacity(0.05)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Weekly Overview Stats
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("This Week")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Spacer()
                        
                        // Time range selector
                        HStack(spacing: 0) {
                            ForEach(timeRanges, id: \.self) { range in
                                Button(action: {
                                    selectedTimeRange = range
                                }) {
                                    Text(range)
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(selectedTimeRange == range ? .white : .black.opacity(0.5))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedTimeRange == range ? .lightBlue : .clear)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .background(.black.opacity(0.05))
                        .cornerRadius(8)
                    }
                    
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 4) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.lightBlue)
                                Text("Total Time")
                                    .font(.DIN(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            
                            HStack(alignment: .bottom, spacing: 4) {
                                Text("\(totalWeekMinutes)")
                                    .font(.DIN(size: 24))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                                
                                Text("min")
                                    .font(.DIN(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                                    .padding(.bottom, 2)
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
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 4) {
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.orange)
                                Text("Calories")
                                    .font(.DIN(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            
                            Text("\(totalWeekCalories)")
                                .font(.DIN(size: 24))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.goldYellow)
                                Text("XP Earned")
                                    .font(.DIN(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            
                            Text("\(totalWeekXP)")
                                .font(.DIN(size: 24))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
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
                .padding(.horizontal)
                
                // Activity Graph
                VStack(alignment: .leading, spacing: 12) {
                    Text("Workout Minutes")
                        .font(.DIN(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Chart {
                        ForEach(weeklyData) { data in
                            BarMark(
                                x: .value("Day", data.day),
                                y: .value("Minutes", data.minutes)
                            )
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.lightBlue, .lightBlue.opacity(0.6)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(4)
                        }
                    }
                    .frame(height: 180)
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black.opacity(0.1), lineWidth: 2)
                )
                .padding(.horizontal)
                
                // Active Challenges
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        HStack(spacing: 6) {
                            Image(systemName: "flag.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.goldYellow)
                            Text("Active Challenges")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        if activeChallenges.count > 2 {
                            Button(action: {
                                showAllChallenges = true
                            }) {
                                Text("See all")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.lightBlue)
                            }
                        }
                    }
                    
                    ForEach(Array(activeChallenges.prefix(2))) { challenge in
                        Button(action: {
                            selectedChallenge = challenge
                        }) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(challenge.name)
                                            .font(.DIN(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Text("Day \(challenge.currentDay) of \(challenge.totalDays)")
                                            .font(.DIN(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 4) {
                                        HStack(spacing: 4) {
                                            Image(systemName: "flame.fill")
                                                .font(.system(size: 12))
                                                .foregroundStyle(.orange)
                                            Text("\(challenge.streak) day")
                                                .font(.DIN(size: 14))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.orange)
                                        }
                                        
                                        Text("\(challenge.completionRate)% accuracy")
                                            .font(.DIN(size: 12))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                }
                                
                                // Progress bar
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(.black.opacity(0.1))
                                            .frame(height: 8)
                                            .cornerRadius(4)
                                        
                                        Rectangle()
                                            .fill(.goldYellow)
                                            .frame(width: geometry.size.width * challenge.progress, height: 8)
                                            .cornerRadius(4)
                                    }
                                }
                                .frame(height: 8)
                                
                                HStack {
                                    Text("\(Int(challenge.progress * 100))% complete")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    Spacer()
                                    
                                    Text("\(challenge.totalDays - challenge.currentDay) days left")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.lightBlue)
                                }
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.goldYellow.opacity(0.3), lineWidth: 2)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Recent Achievements
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(.goldYellow)
                        Text("Recent Achievements")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    
                    HStack(spacing: 12) {
                        ForEach(recentBadges) { badge in
                            VStack(spacing: 8) {
                                ZStack {
                                    Circle()
                                        .fill(badge.color.opacity(0.15))
                                        .frame(width: 60, height: 60)
                                    
                                    Image(systemName: badge.icon)
                                        .font(.system(size: 28))
                                        .foregroundStyle(badge.color)
                                }
                                
                                Text(badge.title)
                                    .font(.DIN(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                                    .multilineTextAlignment(.center)
                                
                                Text(badge.timeAgo)
                                    .font(.DIN(size: 10))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.4))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.black.opacity(0.1), lineWidth: 2)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Friend Activity Feed
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        HStack(spacing: 6) {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.lightBlue)
                            Text("Friend Activity")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showAllActivity = true
                        }) {
                            Text("See all")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.lightBlue)
                        }
                    }
                    
                    ForEach(Array(recentActivity.prefix(3))) { activity in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 12) {
                                // Friend profile pic
                                Circle()
                                    .fill(.lightBlue.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Text(String(activity.friendName.prefix(1)))
                                            .font(.DIN(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.lightBlue)
                                    )
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack(spacing: 4) {
                                        Text(activity.friendName)
                                            .font(.DIN(size: 16))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Text("completed")
                                            .font(.DIN(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    
                                    Text(activity.exerciseName)
                                        .font(.DIN(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.lightBlue)
                                    
                                    Text(activity.timeAgo)
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.4))
                                }
                                
                                Spacer()
                            }
                            
                            // Comparison stats
                            HStack(spacing: 12) {
                                VStack(spacing: 4) {
                                    Text("You")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(activity.yourAccuracy)%")
                                            .font(.DIN(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundStyle(activity.yourAccuracy > activity.friendAccuracy ? .green : .black.opacity(0.7))
                                        
                                        if activity.yourAccuracy > activity.friendAccuracy {
                                            Image(systemName: "arrow.up.circle.fill")
                                                .font(.system(size: 14))
                                                .foregroundStyle(.green)
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.lightBlue.opacity(0.1))
                                .cornerRadius(8)
                                
                                VStack(spacing: 4) {
                                    Text(activity.friendName.components(separatedBy: " ").first ?? "Friend")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(activity.friendAccuracy)%")
                                            .font(.DIN(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundStyle(activity.friendAccuracy > activity.yourAccuracy ? .green : .black.opacity(0.7))
                                        
                                        if activity.friendAccuracy > activity.yourAccuracy {
                                            Image(systemName: "arrow.up.circle.fill")
                                                .font(.system(size: 14))
                                                .foregroundStyle(.green)
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.black.opacity(0.05))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                    .frame(height: 20)
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(item: $selectedChallenge) { challenge in
            // Find the challenge details from mock data
            ChallengeDetailView(
                title: challenge.name,
                itemCount: challenge.totalDays,
                difficulty: "Intermediate"
            )
        }
    }
}

// MARK: - Models
struct ActiveChallenge: Identifiable {
    let id = UUID()
    let name: String
    let currentDay: Int
    let totalDays: Int
    let streak: Int
    let completionRate: Int
    
    var progress: Double {
        Double(currentDay) / Double(totalDays)
    }
}

struct WorkoutDay: Identifiable {
    let id = UUID()
    let day: String
    let minutes: Int
    let calories: Int
    let xp: Int
}

struct FriendActivity: Identifiable {
    let id = UUID()
    let friendName: String
    let friendUsername: String
    let exerciseName: String
    let minutesAgo: Int
    let yourAccuracy: Int
    let friendAccuracy: Int
    
    var timeAgo: String {
        if minutesAgo < 60 {
            return "\(minutesAgo) minutes ago"
        } else if minutesAgo < 1440 {
            let hours = minutesAgo / 60
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        } else {
            let days = minutesAgo / 1440
            return "\(days) day\(days > 1 ? "s" : "") ago"
        }
    }
}

struct Achievement: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let color: Color
    let earnedDaysAgo: Int
    
    var timeAgo: String {
        if earnedDaysAgo == 0 {
            return "Today"
        } else if earnedDaysAgo == 1 {
            return "Yesterday"
        } else {
            return "\(earnedDaysAgo) days ago"
        }
    }
}

#Preview {
    ResultsTab()
}
