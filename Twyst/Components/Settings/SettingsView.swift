//
//  SettingsView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showEditProfile: Bool = false
    @State private var showBodyProfiles: Bool = false
    @State private var showBandanaConnections: Bool = false
    @State private var showAccountSettings: Bool = false
    @State private var showSecuritySettings: Bool = false
    @State private var showPrivacyPolicy: Bool = false
    @State private var showTermsOfService: Bool = false
    @State private var showLanguageSettings: Bool = false
    @State private var showNotificationSettings: Bool = false
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header
            HStack {
                Spacer()
                
                Text("Settings")
                    .font(.DIN(size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(8)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 12)
            .background(Color.white)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Profile")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            SettingsRow(
                                icon: "person.fill",
                                iconColor: .lightBlue,
                                title: "Edit Profile",
                                subtitle: "Name, bio, profile picture"
                            ) {
                                showEditProfile = true
                            }
                            
                            Divider().padding(.leading, 56)
                            
                            SettingsRow(
                                icon: "figure.walk",
                                iconColor: .orange,
                                title: "Body Profiles",
                                subtitle: "Manage measurements"
                            ) {
                                showBodyProfiles = true
                            }
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Twyst Devices Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Twyst Devices")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            SettingsRow(
                                icon: "wifi",
                                iconColor: .lightBlue,
                                title: "Bandana Connections",
                                subtitle: "Manage paired devices"
                            ) {
                                showBandanaConnections = true
                            }
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Account Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Account")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            SettingsRow(
                                icon: "envelope.fill",
                                iconColor: .lightBlue,
                                title: "Account Information",
                                subtitle: "Email, username"
                            ) {
                                showAccountSettings = true
                            }
                            
                            Divider().padding(.leading, 56)
                            
                            SettingsRow(
                                icon: "lock.fill",
                                iconColor: .orange,
                                title: "Security",
                                subtitle: "Password, authentication"
                            ) {
                                showSecuritySettings = true
                            }
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Preferences Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Preferences")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            SettingsRow(
                                icon: "bell.fill",
                                iconColor: .goldYellow,
                                title: "Notifications",
                                subtitle: "Push, email, reminders"
                            ) {
                                showNotificationSettings = true
                            }
                            
                            Divider().padding(.leading, 56)
                            
                            SettingsRow(
                                icon: "globe",
                                iconColor: .lightBlue,
                                title: "Language",
                                subtitle: "English"
                            ) {
                                showLanguageSettings = true
                            }
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Legal Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Legal")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            SettingsRow(
                                icon: "doc.text.fill",
                                iconColor: .gray60,
                                title: "Privacy Policy",
                                subtitle: "How we protect your data"
                            ) {
                                showPrivacyPolicy = true
                            }
                            
                            Divider().padding(.leading, 56)
                            
                            SettingsRow(
                                icon: "doc.text.fill",
                                iconColor: .gray60,
                                title: "Terms of Service",
                                subtitle: "Our terms and conditions"
                            ) {
                                showTermsOfService = true
                            }
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                        .padding(.horizontal)
                    }
                    
                    // App Info
                    VStack(spacing: 4) {
                        Text("Twyst")
                            .font(.DIN(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.5))
                        
                        Text("Version 1.0.0")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.4))
                    }
                    .padding(.vertical)
                    
                    // Logout Button
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Text("Log Out")
                            .font(.DIN())
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.customRed)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 20)
                }
                .padding(.top)
            }
            .background(Color.white)
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView()
        }
        .fullScreenCover(isPresented: $showBodyProfiles) {
            BodyProfilesView()
        }
        .fullScreenCover(isPresented: $showBandanaConnections) {
            BandanaConnectionsView()
        }
        .fullScreenCover(isPresented: $showAccountSettings) {
            AccountSettingsView()
        }
        .fullScreenCover(isPresented: $showSecuritySettings) {
            SecuritySettingsView()
        }
        .fullScreenCover(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView()
        }
        .fullScreenCover(isPresented: $showTermsOfService) {
            TermsOfServiceView()
        }
        .fullScreenCover(isPresented: $showLanguageSettings) {
            LanguageSettingsView()
        }
        .fullScreenCover(isPresented: $showNotificationSettings) {
            NotificationSettingsView()
        }
        .alert("Log Out", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Log Out", role: .destructive) {
                // Handle logout
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
}

// MARK: - Settings Row Component
struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.DIN(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text(subtitle)
                        .font(.DIN(size: 14))
                        .fontWeight(.regular)
                        .foregroundStyle(.black.opacity(0.5))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(.black.opacity(0.3))
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}

