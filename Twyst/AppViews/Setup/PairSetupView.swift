//
//  SetupView.swift
//  Twyst
//
//  Created by Karo on 04.10.2025.
//

import SwiftUI

struct PairSetupView: View {
    var onComplete: () -> Void

    var body: some View {
        VStack {
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 24) {
                    Text(
                        "The Twyst ecosystem heavily relies on its bandanas to track your body motion. For that to work, you need to pair them to your device."
                    ).font(.DIN()).fontWeight(.medium).foregroundStyle(
                        .black.opacity(0.6))

                    Text("Please turn on Twyst to connect.").font(.DIN())
                        .fontWeight(
                            .medium
                        ).foregroundStyle(.black.opacity(0.6))
                }

                VStack(spacing: 12) {
                    PairButton(
                        id: "aSzk54Hjmy68", version: "Twyst-1.3",
                        bandanaCount: 4, paired: false
                    ) {

                    }

                    PairButton(
                        id: "Xa12QEr7HqM5", version: "Pro-1.0", bandanaCount: 4,
                        paired: false
                    ) {

                    }

                    PairButton(
                        id: "CfGu2ski2h1b", version: "Kid-1.2", bandanaCount: 6,
                        paired: true
                    ) {

                    }
                }
            }

            Spacer()

            PrimitiveButton(content: "Continue", type: .primary) {
                onComplete()
            }
        }.padding(.top, 24).toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Text("Connecting Twyst")
                        .font(.DIN(size: 20))
                        .foregroundColor(.black.opacity(0.7)).fontWeight(.bold)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("SKIP").font(.DIN()).fontWeight(.bold).foregroundStyle(
                    .black.opacity(0.2)).onTapGesture {
                        onComplete()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
    }
}

#Preview {
    PairSetupView(onComplete: {})
}
