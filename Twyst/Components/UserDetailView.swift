//
//  UserDetailView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.dismiss) var dismiss
    let username: String
    let name: String
    let followers: Int
    
    @State private var isFollowing: Bool = false
    @State private var showFollowers: Bool = false
    @State private var showFollowing: Bool = false
    @State private var showBlockAlert: Bool = false
    @State private var showReportSheet: Bool = false
    
    // Mock data - same for all users
    let bio = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"
    let joinDate = "September 2025"
    
    // Cached random stats
    let following: Int
    let courses: Int
    let dayStreak: Int
    let avgAccuracy: String
    let totalXP: String
    let gymScore: Int
    
    init(username: String, name: String, followers: Int) {
        self.username = username
        self.name = name
        self.followers = followers
        
        // Initialize random stats once
        self.following = Int.random(in: 20...150)
        self.courses = Int.random(in: 3...12)
        self.dayStreak = Int.random(in: 1...365)
        self.avgAccuracy = "\(Int.random(in: 65...99))%"
        self.totalXP = "\(Int.random(in: 1000...9999)) XP"
        self.gymScore = Int.random(in: 10...50)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header with back button
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
                
                Menu {
                    Button(action: {
                        showBlockAlert = true
                    }) {
                        Label("Block User", systemImage: "hand.raised.fill")
                    }
                    
                    Button(action: {
                        showReportSheet = true
                    }) {
                        Label("Report User", systemImage: "exclamationmark.triangle.fill")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 24))
                        .foregroundStyle(.black.opacity(0.7))
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 12)
            .background(Color.white)
            
            ScrollView {
                VStack {
                    // Header with background and profile image
                    VStack {
                        Spacer()
                        
                        Image("profile-pic")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                }
                .frame(height: 260)
                .frame(maxWidth: .infinity)
                .background {
                    Image("login-bg")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 800)
                        .frame(width: UIScreen.main.bounds.width, height: 260)
                        .clipped()
                }
                .background(.lightBlue.opacity(0.6))
                
                // User info section
                VStack(alignment: .leading) {
                    VStack {
                        Text(name)
                            .font(.DIN(size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("@\(username) · Joined \(joinDate)")
                            .font(.DIN())
                            .fontWeight(.regular)
                            .foregroundStyle(.black.opacity(0.7))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Text(bio)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.DIN())
                        .fontWeight(.medium)
                        .padding(.top, 8)
                        .foregroundStyle(.black.opacity(0.6))
                    
                    // Stats row
                    HStack(spacing: 18) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "dumbbell.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(3.5)
                                    .frame(width: 32, height: 22)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(.goldYellow, lineWidth: 2)
                                    )
                                    .foregroundStyle(.goldYellow)
                                
                                Text("+\(courses-1)")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.3))
                                    .padding(3.5)
                                    .frame(width: 32, height: 22)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(.black.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            Text("Courses")
                                .font(.DIN())
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Rectangle()
                            .frame(width: 2, height: 40)
                            .foregroundStyle(.black.opacity(0.1))
                        
                        Button(action: {
                            showFollowers = true
                        }) {
                            VStack(alignment: .leading) {
                                Text("\(followers)")
                                    .font(.DIN(size: 20))
                                    .bold()
                                
                                Text("Followers")
                                    .font(.DIN())
                                    .fontWeight(.regular)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                        }
                        .foregroundStyle(.black)
                        
                        Rectangle()
                            .frame(width: 2, height: 40)
                            .foregroundStyle(.black.opacity(0.1))
                        
                        Button(action: {
                            showFollowing = true
                        }) {
                            VStack(alignment: .leading) {
                                Text("\(following)")
                                    .font(.DIN(size: 20))
                                    .bold()
                                
                                Text("Following")
                                    .font(.DIN())
                                    .fontWeight(.regular)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                        }
                        .foregroundStyle(.black)
                    }
                    .padding(.top)
                    
                    // Follow button
                    PrimitiveButton(
                        content: isFollowing ? "Following" : "+ Follow",
                        type: isFollowing ? .secondary : .primary
                    ) {
                        isFollowing.toggle()
                    }
                    .padding(.top)
                    
                    // Overview section
                    Text("Overview")
                        .font(.DIN(size: 24))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    HStack {
                        StatBox(value: "\(dayStreak)", description: "Day streak") {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(.orange)
                                .font(.system(size: 24))
                        }
                        
                        StatBox(value: avgAccuracy, description: "Avg. accuracy") {
                            Image(systemName: "percent")
                                .foregroundStyle(.green)
                                .bold()
                                .font(.system(size: 24))
                        }
                    }
                    
                    HStack {
                        StatBox(value: totalXP, description: "Total XP") {
                            Image(systemName: "sparkles")
                                .foregroundStyle(.goldYellow)
                                .font(.system(size: 24))
                        }
                        
                        StatBox(value: "\(gymScore)", description: "Gym score") {
                            Image(systemName: "dumbbell.fill")
                                .foregroundStyle(.gray60)
                                .font(.system(size: 24))
                                .bold()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
                Spacer()
                }
            }
        }
        .background(Color.white)
        .alert("Block User", isPresented: $showBlockAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Block", role: .destructive) {
                // Handle block action
                dismiss()
            }
        } message: {
            Text("Are you sure you want to block @\(username)? They won't be able to see your profile or contact you.")
        }
        .fullScreenCover(isPresented: $showReportSheet) {
            ReportUserView(username: username)
        }
        .fullScreenCover(isPresented: $showFollowers) {
            FollowersListView(title: "Followers", count: followers)
        }
        .fullScreenCover(isPresented: $showFollowing) {
            FollowersListView(title: "Following", count: following)
        }
    }
}

#Preview {
    UserDetailView(username: "emilyjohnson", name: "Emily Johnson", followers: 234)
}

