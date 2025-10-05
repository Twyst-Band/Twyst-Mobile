//
//  PathTab.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct PathTab: View {
    @State private var selectedCategory: FitnessCategory? = nil
    
    let currentStreak = 12
    let totalXP = 4527
    let dailyGoalXP = 50
    let earnedTodayXP = 35
    
    let categories: [FitnessCategory] = [
        FitnessCategory(
            id: 1,
            name: "Calisthenics",
            icon: "figure.mixed.cardio",
            color: .blue,
            totalExercises: 24,
            completedExercises: 12,
            isLocked: false
        ),
        FitnessCategory(
            id: 2,
            name: "Yoga & Flexibility",
            icon: "figure.yoga",
            color: .purple,
            totalExercises: 20,
            completedExercises: 8,
            isLocked: false
        ),
        FitnessCategory(
            id: 3,
            name: "Strength Training",
            icon: "dumbbell.fill",
            color: .red,
            totalExercises: 28,
            completedExercises: 5,
            isLocked: false
        ),
        FitnessCategory(
            id: 4,
            name: "Cardio & HIIT",
            icon: "flame.fill",
            color: .orange,
            totalExercises: 18,
            completedExercises: 3,
            isLocked: false
        ),
        FitnessCategory(
            id: 5,
            name: "Core & Balance",
            icon: "figure.core.training",
            color: .green,
            totalExercises: 16,
            completedExercises: 0,
            isLocked: true
        ),
        FitnessCategory(
            id: 6,
            name: "Mobility",
            icon: "figure.flexibility",
            color: .cyan,
            totalExercises: 14,
            completedExercises: 0,
            isLocked: true
        )
    ]
    
    var dailyGoalProgress: Double {
        min(Double(earnedTodayXP) / Double(dailyGoalXP), 1.0)
    }
    
    var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 {
            return "Good morning"
        } else if hour < 18 {
            return "Good afternoon"
        } else {
            return "Good evening"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header Section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Ready to Twyst?")
                        .font(.DIN(size: 22))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.8))
                    
                    Spacer()
                    
                    // Streak
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(.orange)
                        
                        Text("\(currentStreak)")
                            .font(.DIN(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightGray, lineWidth: 2)
                    )
                    
                    // XP
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 14))
                            .foregroundStyle(.goldYellow)
                        
                        Text("\(totalXP)")
                            .font(.DIN(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightGray, lineWidth: 2)
                    )
                }
            
            }
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
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: 8)
                    
                    // Daily Goal Card
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "target")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.lightBlue)
                                    
                                    Text("Daily Goal")
                                        .font(.DIN(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.8))
                                }
                                
                                Text("Earn \(dailyGoalXP) XP to complete your goal!")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                            
                            Spacer()
                            
                            // Circular Progress
                            ZStack {
                                Circle()
                                    .stroke(.black.opacity(0.1), lineWidth: 8)
                                    .frame(width: 70, height: 70)
                                
                                Circle()
                                    .trim(from: 0, to: dailyGoalProgress)
                                    .stroke(
                                        Color.green,
                                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                                    )
                                    .frame(width: 70, height: 70)
                                    .rotationEffect(.degrees(-90))
                                
                                VStack(spacing: 0) {
                                    Text("\(earnedTodayXP)")
                                        .font(.DIN(size: 18))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.8))
                                    
                                    Text("/ \(dailyGoalXP)")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                            }
                        }
                        
                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.black.opacity(0.1))
                                    .frame(height: 12)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.green)
                                    .frame(width: geometry.size.width * dailyGoalProgress, height: 12)
                            }
                        }
                        .frame(height: 12)
                        
                        if dailyGoalProgress >= 1.0 {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.green)
                                
                                Text("Goal completed! 🎉")
                                    .font(.DIN(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                                
                                Spacer()
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
                    .padding(.horizontal)
                    
                    // Categories Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Skill Trees")
                                .font(.DIN(size: 28))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.85))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Category Grid
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(categories) { category in
                                CategoryCardView(category: category) {
                                    if !category.isLocked {
                                        selectedCategory = category
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Quick Stats
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 6) {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.lightBlue)
                                
                                Text("Your Progress")
                                    .font(.DIN(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.8))
                            }
                            
                            HStack(spacing: 12) {
                                VStack(alignment: .center, spacing: 4) {
                                    Text("28")
                                        .font(.DIN(size: 24))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.8))
                                    
                                    Text("Exercises\nCompleted")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(height: 40)
                                
                                VStack(alignment: .center, spacing: 4) {
                                    Text("4")
                                        .font(.DIN(size: 24))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.8))
                                    
                                    Text("Trees\nStarted")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(height: 40)
                                
                                VStack(alignment: .center, spacing: 4) {
                                    Text("12")
                                        .font(.DIN(size: 24))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.orange)
                                    
                                    Text("Day\nStreak")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.lightGray, lineWidth: 2)
                    )
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 20)
                }
            }
        }
        .fullScreenCover(item: $selectedCategory) { category in
            CategorySkillTreeView(category: category)
        }
    }
}

// MARK: - Category Card View
struct CategoryCardView: View {
    let category: FitnessCategory
    let onTap: () -> Void
    
    var progressPercentage: Int {
        guard category.totalExercises > 0 else { return 0 }
        return Int((Double(category.completedExercises) / Double(category.totalExercises)) * 100)
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                // Icon Section
                ZStack {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 10,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 10
                    )
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                category.color,
                                category.color.opacity(0.8)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 110)
                    
                    if category.isLocked {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(.white.opacity(0.9))
                    } else {
                        VStack(spacing: 6) {
                            Image(systemName: category.icon)
                                .font(.system(size: 36))
                                .foregroundStyle(.white)
                            
                            Text("\(progressPercentage)%")
                                .font(.DIN(size: 15))
                                .fontWeight(.bold)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    }
                }
                
                // Info Section
                VStack(alignment: .leading, spacing: 6) {
                    Text(category.name)
                        .font(.DIN(size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.85))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    if !category.isLocked {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 11))
                                .foregroundStyle(.green)
                            
                            Text("\(category.completedExercises)/\(category.totalExercises)")
                                .font(.DIN(size: 13))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                        }
                    } else {
                        HStack(spacing: 4) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 9))
                                .foregroundStyle(.black.opacity(0.4))
                            
                            Text("Locked")
                                .font(.DIN(size: 13))
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.4))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.white)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightGray, lineWidth: 2)
            )
        }
        .disabled(category.isLocked)
        .opacity(category.isLocked ? 0.65 : 1.0)
    }
}

// MARK: - Models
struct FitnessCategory: Identifiable {
    let id: Int
    let name: String
    let icon: String
    let color: Color
    let totalExercises: Int
    let completedExercises: Int
    let isLocked: Bool
}

#Preview {
    PathTab()
}
