//
//  ClickableExerciseCard.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ClickableExerciseCard: View {
    let title: String
    let duration: String
    let difficulty: String
    let category: String
    let isPurchased: Bool
    
    @State private var showDetail: Bool = false
    
    var body: some View {
        Button(action: {
            showDetail = true
        }) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.DIN(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Text(category)
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    
                    Spacer()
                    
                    if isPurchased {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.goldYellow)
                            .font(.system(size: 24))
                    } else {
                        Image(systemName: "lock.circle.fill")
                            .foregroundStyle(.black.opacity(0.3))
                            .font(.system(size: 24))
                    }
                }
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(.lightBlue)
                        Text(duration)
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(.lightBlue)
                        Text(difficulty)
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black.opacity(0.1), lineWidth: 2)
            )
        }
        .fullScreenCover(isPresented: $showDetail) {
            ExerciseDetailView(
                title: title,
                duration: duration,
                difficulty: difficulty,
                category: category
            )
        }
    }
}

#Preview {
    ClickableExerciseCard(
        title: "Push-ups",
        duration: "10 min",
        difficulty: "Beginner",
        category: "Strength",
        isPurchased: true
    )
    .padding()
}

