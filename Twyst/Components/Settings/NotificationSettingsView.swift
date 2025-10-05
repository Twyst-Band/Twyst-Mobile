//
//  NotificationSettingsView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct NotificationSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var pushEnabled: Bool = true
    @State private var emailEnabled: Bool = true
    @State private var workoutReminders: Bool = true
    @State private var challengeUpdates: Bool = true
    @State private var friendActivity: Bool = true
    @State private var achievements: Bool = true
    @State private var weeklyReports: Bool = true
    @State private var promotions: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // General Notifications
                    VStack(alignment: .leading, spacing: 12) {
                        Text("General")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(spacing: 0) {
                            NotificationToggle(
                                title: "Push Notifications",
                                subtitle: "Receive push notifications on this device",
                                isOn: $pushEnabled
                            )
                            
                            Divider().padding(.leading, 16)
                            
                            NotificationToggle(
                                title: "Email Notifications",
                                subtitle: "Receive updates via email",
                                isOn: $emailEnabled
                            )
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                    }
                    
                    // Activity Notifications
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Activity")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(spacing: 0) {
                            NotificationToggle(
                                title: "Workout Reminders",
                                subtitle: "Daily reminders to stay active",
                                isOn: $workoutReminders
                            )
                            
                            Divider().padding(.leading, 16)
                            
                            NotificationToggle(
                                title: "Challenge Updates",
                                subtitle: "Progress and milestone notifications",
                                isOn: $challengeUpdates
                            )
                            
                            Divider().padding(.leading, 16)
                            
                            NotificationToggle(
                                title: "Friend Activity",
                                subtitle: "When friends complete workouts",
                                isOn: $friendActivity
                            )
                            
                            Divider().padding(.leading, 16)
                            
                            NotificationToggle(
                                title: "Achievements",
                                subtitle: "When you earn badges and rewards",
                                isOn: $achievements
                            )
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                    }
                    
                    // Marketing Notifications
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Marketing")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(spacing: 0) {
                            NotificationToggle(
                                title: "Weekly Reports",
                                subtitle: "Weekly fitness summaries",
                                isOn: $weeklyReports
                            )
                            
                            Divider().padding(.leading, 16)
                            
                            NotificationToggle(
                                title: "Promotions & Offers",
                                subtitle: "Special deals and discounts",
                                isOn: $promotions
                            )
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
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
                }
            }
        }
    }
}

// MARK: - Notification Toggle Component
struct NotificationToggle: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.DIN())
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Text(subtitle)
                    .font(.DIN(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.5))
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.lightBlue)
        }
        .padding()
    }
}

#Preview {
    NotificationSettingsView()
}

