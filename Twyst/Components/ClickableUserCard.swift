//
//  ClickableUserCard.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ClickableUserCard: View {
    let name: String
    let username: String
    let followers: Int
    
    @State private var showDetail: Bool = false
    
    var body: some View {
        Button(action: {
            showDetail = true
        }) {
            HStack(spacing: 12) {
                Image("profile-pic")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.DIN(size: 16))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("@\(username)")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
                
                Spacer()
                
                Text("\(followers) followers")
                    .font(.DIN(size: 12))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.4))
            }
            .padding(12)
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black.opacity(0.1), lineWidth: 2)
            )
        }
        .fullScreenCover(isPresented: $showDetail) {
            UserDetailView(username: username, name: name, followers: followers)
        }
    }
}

#Preview {
    ClickableUserCard(name: "Emily Johnson", username: "emilyjohnson", followers: 234)
        .padding()
}

