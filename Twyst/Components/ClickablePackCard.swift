//
//  ClickablePackCard.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ClickablePackCard: View {
    let title: String
    let itemCount: Int
    let type: String
    let difficulty: String
    
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
                        
                        Text("\(itemCount) exercises")
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    
                    Spacer()
                    
                    Image(systemName: type == "pack" ? "square.stack.3d.up.fill" : "flag.fill")
                        .foregroundStyle(.lightBlue)
                        .font(.system(size: 24))
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
            if type == "challenge" {
                ChallengeDetailView(
                    title: title,
                    itemCount: itemCount,
                    difficulty: difficulty
                )
            } else {
                PackDetailView(
                    title: title,
                    itemCount: itemCount,
                    type: type,
                    difficulty: difficulty
                )
            }
        }
    }
}

#Preview {
    ClickablePackCard(
        title: "Beginner's Bundle",
        itemCount: 12,
        type: "pack",
        difficulty: "Beginner"
    )
    .padding()
}

