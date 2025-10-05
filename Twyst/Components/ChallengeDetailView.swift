//
//  ChallengeDetailView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ChallengeDetailView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let itemCount: Int
    let difficulty: String
    
    @State private var isFavorited: Bool = false
    @State private var isEnrolled: Bool
    @State private var selectedExercise: (String, String, String, String)? = nil
    
    // Cached random mock data
    let price: Int
    let totalXP: Int
    let duration: Int
    let participants: Int
    
    // Cached progress data (if enrolled)
    let currentDay: Int
    let completedDays: Int
    let currentStreak: Int
    let completionRate: Int
    
    let description: String
    let benefits: [String]
    let dailyExercises: [(String, String, String, String)]
    
    init(title: String, itemCount: Int, difficulty: String) {
        self.title = title
        self.itemCount = itemCount
        self.difficulty = difficulty
        
        // Initialize random data once
        _isEnrolled = State(initialValue: Bool.random())
        self.price = Int.random(in: 10...75)
        self.totalXP = Int.random(in: 200...2000)
        self.duration = Int.random(in: 7...90)
        self.participants = Int.random(in: 150...5000)
        
        // Initialize progress data
        self.currentDay = Int.random(in: 1...30)
        self.completedDays = Int.random(in: 0...25)
        self.currentStreak = Int.random(in: 0...20)
        self.completionRate = Int.random(in: 60...100)
        
        // Cache description
        self.description = "Transform your fitness journey with this \(self.duration)-day progressive challenge. Designed for \(difficulty.lowercased()) level participants, this challenge includes daily workouts that increase in intensity as you progress. Join thousands of others and push your limits!"
        
        // Cache benefits
        let allBenefits = [
            "Daily structured workouts",
            "Progressive difficulty scaling",
            "Community leaderboard",
            "Achievement badges & rewards",
            "Rest day recommendations",
            "Progress tracking dashboard",
            "Motivational notifications",
            "Expert coaching tips"
        ]
        self.benefits = Array(allBenefits.shuffled().prefix(5))
        
        // Cache daily exercises
        let exercises = MockLibraryData.allExercises.shuffled()
        self.dailyExercises = Array(exercises.prefix(itemCount))
    }
    
    var difficultyColor: Color {
        switch difficulty {
        case "Beginner": return .green
        case "Intermediate": return .orange
        case "Advanced": return .customRed
        default: return .gray
        }
    }
    
    var progressPercentage: Double {
        Double(completedDays) / Double(duration)
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
                    // Challenge Icon and Title
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "flag.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.goldYellow)
                    
                    Text(title)
                        .font(.DIN(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    HStack(spacing: 12) {
                        // Challenge badge
                        Text("Challenge")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.goldYellow)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.goldYellow.opacity(0.15))
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
                        
                        // Duration badge
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .font(.system(size: 12))
                            Text("\(duration) Days")
                                .font(.DIN(size: 14))
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.lightBlue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.lightBlue.opacity(0.15))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Progress section (if enrolled)
                if isEnrolled {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 6) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 18))
                                .foregroundStyle(.goldYellow)
                            Text("Your Progress")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        VStack(spacing: 16) {
                            // Progress bar
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Day \(currentDay) of \(duration)")
                                        .font(.DIN(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Spacer()
                                    
                                    Text("\(Int(progressPercentage * 100))%")
                                        .font(.DIN(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.goldYellow)
                                }
                                
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(.black.opacity(0.1))
                                            .frame(height: 12)
                                            .cornerRadius(6)
                                        
                                        Rectangle()
                                            .fill(.goldYellow)
                                            .frame(width: geometry.size.width * progressPercentage, height: 12)
                                            .cornerRadius(6)
                                    }
                                }
                                .frame(height: 12)
                            }
                            
                            // Stats grid
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Completed")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(completedDays)")
                                            .font(.DIN(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.green)
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
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Streak")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(currentStreak)")
                                            .font(.DIN(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.orange)
                                        
                                        Image(systemName: "flame.fill")
                                            .foregroundStyle(.orange)
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
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Accuracy")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                    
                                    HStack(spacing: 4) {
                                        Text("\(completionRate)%")
                                            .font(.DIN(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.lightBlue)
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
                    .background(.goldYellow.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                // Quick stats
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(.lightBlue)
                            Text("\(participants)")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Text("Participants")
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
                            Text("\(totalXP)")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Text("Total XP")
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
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("About This Challenge")
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
                
                // Benefits
                VStack(alignment: .leading, spacing: 12) {
                    Text("What's Included")
                        .font(.DIN(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    ForEach(benefits, id: \.self) { benefit in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.green)
                            
                            Text(benefit)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                        }
                    }
                }
                .padding(.horizontal)
                
                // Daily exercises
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Daily Exercises (\(itemCount))")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Spacer()
                        
                        Text("Progressive difficulty")
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.lightBlue)
                    }
                    
                    Text("Each day features a curated workout to keep you challenged")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                    
                    VStack(spacing: 10) {
                        ForEach(Array(dailyExercises.enumerated()), id: \.offset) { index, exercise in
                            Button(action: {
                                selectedExercise = exercise
                            }) {
                                HStack(spacing: 12) {
                                    // Day badge
                                    VStack(spacing: 2) {
                                        Text("DAY")
                                            .font(.DIN(size: 8))
                                            .fontWeight(.bold)
                                        Text("\(index + 1)")
                                            .font(.DIN(size: 16))
                                            .fontWeight(.bold)
                                    }
                                    .foregroundStyle(.white)
                                    .frame(width: 40, height: 40)
                                    .background(
                                        isEnrolled && index < currentDay ? .green :
                                        isEnrolled && index == currentDay - 1 ? .goldYellow : .lightBlue
                                    )
                                    .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(exercise.0)
                                            .font(.DIN(size: 16))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        HStack(spacing: 8) {
                                            HStack(spacing: 4) {
                                                Image(systemName: "clock.fill")
                                                    .font(.system(size: 10))
                                                    .foregroundStyle(.lightBlue)
                                                Text(exercise.1)
                                                    .font(.DIN(size: 12))
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.black.opacity(0.5))
                                            }
                                            
                                            Text("•")
                                                .foregroundStyle(.black.opacity(0.3))
                                            
                                            Text(exercise.2)
                                                .font(.DIN(size: 12))
                                                .fontWeight(.medium)
                                                .foregroundStyle(.black.opacity(0.5))
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if isEnrolled && index < currentDay - 1 {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.green)
                                    } else {
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14))
                                            .foregroundStyle(.black.opacity(0.3))
                                    }
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            isEnrolled && index == currentDay - 1 ? .goldYellow : .black.opacity(0.1),
                                            lineWidth: isEnrolled && index == currentDay - 1 ? 3 : 2
                                        )
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Join/Continue button
                if isEnrolled {
                    PrimitiveButton(content: "Continue Challenge", type: .primary) {
                        // Handle continue
                    }
                    .padding(.horizontal)
                } else {
                    VStack(spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Price")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                Text("$\(price)")
                                    .font(.DIN(size: 32))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("Join \(participants)+ others")
                                    .font(.DIN(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                        }
                        .padding()
                        .background(.goldYellow.opacity(0.1))
                        .cornerRadius(12)
                        
                        PrimitiveButton(content: "Join Challenge", type: .primary) {
                            // Handle join
                            isEnrolled = true
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                    .frame(height: 20)
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(item: Binding(
            get: { selectedExercise.map { ExerciseIdentifier(exercise: $0) } },
            set: { selectedExercise = $0?.exercise }
        )) { identifier in
            ExerciseDetailView(
                title: identifier.exercise.0,
                duration: identifier.exercise.1,
                difficulty: identifier.exercise.2,
                category: identifier.exercise.3
            )
        }
    }
}

#Preview {
    ChallengeDetailView(
        title: "30-Day Transformation",
        itemCount: 30,
        difficulty: "Intermediate"
    )
}

