//
//  HeroView.swift
//  Twyst
//
//  Created by Karo on 04.10.2025.
//

import SwiftUI

struct HeroView: View {
    var onLogin: () -> Void;
    var onRegister: () -> Void;

    var body: some View {
        VStack(spacing: 120) {
            VStack(spacing: 60) {
                Image("twy-login").resizable().scaledToFit().frame(
                    maxWidth: .infinity
                ).padding(.horizontal, 80)
                VStack(spacing: 20) {
                    Image("logo").resizable().scaledToFit().frame(maxWidth: .infinity)
                        .padding(.horizontal, 80)
                    Text("Lorem Ipsum Dolor Sit Amet. Let em.").font(.DIN()).foregroundColor(.gray60)
                }
            }
            
            VStack(spacing: 12) {
                PrimitiveButton(content: "Get Started", type: .primary) {
                    onRegister();
                }
                PrimitiveButton(content: "I already have an account", type: .secondary) {
                    onLogin();
                }
            }
        }.frame(maxHeight: .infinity)
            .padding()
            .background {
                Image("login-bg").resizable()
                    .scaledToFill()
                    .clipped()
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    HeroView(onLogin: {
        
    }, onRegister: {
        
    });
}
