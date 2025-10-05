//
//  BodyProfileSetupView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct BodyProfileSetupView: View {
    var onComplete: () -> Void
    var onBack: () -> Void

    var body: some View {
        VStack {
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 24) {
                    Text(
                        "For exercises to be measured correctly for you, we must know the size of your arms, legs, torso and your height."
                    ).font(.DIN()).fontWeight(.medium).foregroundStyle(
                        .black.opacity(0.6))
                    
                    Text("You can manually enter these numbers or automatically take the measurements using the camera (takes 2 minutes).").font(.DIN())
                        .fontWeight(
                            .medium
                        ).foregroundStyle(.black.opacity(0.6))
                }
            }

            Spacer()

            PrimitiveButton(content: "Continue", type: .primary) {
                onComplete()
            }
            
            PrimitiveButton(content: "Enter manually", type: .secondary) {
                onComplete()
            }
            
            PrimitiveButton(content: "Skip", type: .tertiary) {
                onComplete()
            }
        }.padding(.top, 24).toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left").foregroundStyle(
                            .black.opacity(0.6))
                    }
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
    BodyProfileSetupView(onComplete: {}, onBack: {})
}
