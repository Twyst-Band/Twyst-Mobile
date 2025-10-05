//
//  FollowersListView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct FollowersListView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let count: Int
    
    @State private var searchText: String = ""
    
    // Generate mock followers list based on count
    var mockFollowers: [(String, String, Int)] {
        let users = MockLibraryData.allUsers
        let selectedCount = min(count, users.count)
        return Array(users.prefix(selectedCount))
    }
    
    var filteredFollowers: [(String, String, Int)] {
        if searchText.isEmpty {
            return mockFollowers
        }
        return mockFollowers.filter { user in
            user.0.lowercased().contains(searchText.lowercased()) ||
            user.1.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16))
                        Text("Back")
                            .font(.DIN())
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(.lightBlue)
                }
                
                Spacer()
                
                Text(title)
                    .font(.DIN(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Spacer()
                
                // Placeholder for symmetry
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                    Text("Back")
                        .font(.DIN())
                        .fontWeight(.medium)
                }
                .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.black.opacity(0.5))
                TextField("Search \(title.lowercased())", text: $searchText)
                    .font(.DIN())
                    .fontWeight(.medium)
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightGray, lineWidth: 2)
            )
            .padding()
            
            // User list
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(filteredFollowers, id: \.1) { user in
                        ClickableUserCard(
                            name: user.0,
                            username: user.1,
                            followers: user.2
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

#Preview {
    FollowersListView(title: "Followers", count: 42)
}

