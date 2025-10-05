//
//  PackDetailView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct PackDetailView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let itemCount: Int
    let type: String
    let difficulty: String
    
    @State private var isPurchased: Bool = Bool.random()
    @State private var isFavorited: Bool = false
    @State private var selectedExercise: (String, String, String, String)? = nil
    
    // Random mock data
    let price = Int.random(in: 5...50)
    let totalXP = Int.random(in: 100...1000)
    let estimatedDays = Int.random(in: 7...90)
    
    var description: String {
        if type == "pack" {
            return "This comprehensive exercise pack includes a carefully curated selection of workouts designed to help you achieve your fitness goals. Perfect for \(difficulty.lowercased()) level athletes looking to build strength, improve endurance, and maintain consistency."
        } else {
            return "Join this \(estimatedDays)-day challenge to push your limits and transform your fitness journey. This progressive challenge is designed for \(difficulty.lowercased()) level participants and includes daily exercises with increasing difficulty."
        }
    }
    
    var benefits: [String] {
        let allBenefits = [
            "Structured progression system",
            "Complete workout variety",
            "Expert-designed routines",
            "Progress tracking included",
            "Suitable for home or gym",
            "Flexible scheduling options",
            "Video demonstrations",
            "Community support access"
        ]
        return Array(allBenefits.shuffled().prefix(4))
    }
    
    var includedExercises: [(String, String, String, String)] {
        let exercises = MockLibraryData.allExercises.shuffled()
        return Array(exercises.prefix(itemCount))
    }
    
    var difficultyColor: Color {
        switch difficulty {
        case "Beginner": return .green
        case "Intermediate": return .orange
        case "Advanced": return .customRed
        default: return .gray
        }
    }
    
    var iconName: String {
        type == "pack" ? "square.stack.3d.up.fill" : "flag.fill"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with back button
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
                
                // Icon and Title
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: iconName)
                        .font(.system(size: 48))
                        .foregroundStyle(.lightBlue)
                    
                    Text(title)
                        .font(.DIN(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    HStack(spacing: 12) {
                        // Type badge
                        Text(type == "pack" ? "Exercise Pack" : "Challenge")
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
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Image(systemName: type == "pack" ? "list.bullet" : "calendar")
                                .font(.system(size: 12))
                                .foregroundStyle(.lightBlue)
                            Text("\(itemCount)")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Text(type == "pack" ? "Exercises" : "Days")
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
                    
                    if type == "challenge" {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 4) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.orange)
                                Text("\(estimatedDays)")
                                    .font(.DIN(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            Text("Days")
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
                }
                .padding(.horizontal)
                
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
                
                // Exercises list
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Exercises (\(itemCount))")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Spacer()
                        
                        if type == "challenge" {
                            Text("Progressive difficulty")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.lightBlue)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        ForEach(Array(includedExercises.enumerated()), id: \.offset) { index, exercise in
                            Button(action: {
                                selectedExercise = exercise
                            }) {
                                HStack(spacing: 12) {
                                    // Number badge
                                    Text("\(index + 1)")
                                        .font(.DIN(size: 14))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(width: 32, height: 32)
                                        .background(.lightBlue)
                                        .clipShape(Circle())
                                    
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
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.black.opacity(0.3))
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black.opacity(0.1), lineWidth: 2)
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Purchase/Start button
                if isPurchased {
                    PrimitiveButton(content: type == "pack" ? "View Exercises" : "Start Challenge", type: .primary) {
                        // Handle start
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
                        }
                        .padding()
                        .background(.goldYellow.opacity(0.1))
                        .cornerRadius(12)
                        
                        PrimitiveButton(content: "Purchase \(type == "pack" ? "Pack" : "Challenge")", type: .primary) {
                            // Handle purchase
                            isPurchased = true
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                    .frame(height: 20)
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

// Helper struct to make the exercise identifiable for fullScreenCover
struct ExerciseIdentifier: Identifiable {
    let id = UUID()
    let exercise: (String, String, String, String)
}

#Preview {
    PackDetailView(
        title: "Beginner's Bundle",
        itemCount: 12,
        type: "pack",
        difficulty: "Beginner"
    )
}

