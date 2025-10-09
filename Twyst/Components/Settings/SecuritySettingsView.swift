//
//  SecuritySettingsView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct SecuritySettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var biometricEnabled: Bool = true
    @State private var twoFactorEnabled: Bool = false
    @State private var showPasswordSuccess: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header
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
                
                Text("Security Settings")
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
            .padding(.bottom, 12)
            .background(Color.white)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Change Password
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Change Password")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Current Password")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            SecureField("", text: $currentPassword)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("New Password")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            SecureField("", text: $newPassword)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirm New Password")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            SecureField("", text: $confirmPassword)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        PrimitiveButton(content: "Update Password", type: .primary) {
                            // Handle password update
                            showPasswordSuccess = true
                        }
                    }
                    
                    // Security Options
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Security Options")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(spacing: 0) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Face ID / Touch ID")
                                        .font(.DIN())
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Text("Use biometric authentication")
                                        .font(.DIN(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $biometricEnabled)
                                    .labelsHidden()
                                    .tint(.lightBlue)
                            }
                            .padding()
                            
                            Divider()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Two-Factor Authentication")
                                        .font(.DIN())
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Text("Add extra security to your account")
                                        .font(.DIN(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $twoFactorEnabled)
                                    .labelsHidden()
                                    .tint(.lightBlue)
                            }
                            .padding()
                        }
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black.opacity(0.1), lineWidth: 2)
                        )
                    }
                    
                    // Active Sessions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Active Sessions")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(spacing: 12) {
                            ActiveSessionCard(
                                deviceName: "iPhone 15 Pro",
                                location: "San Francisco, CA",
                                lastActive: "Now",
                                isCurrent: true
                            )
                            
                            ActiveSessionCard(
                                deviceName: "iPad Pro",
                                location: "San Francisco, CA",
                                lastActive: "2 days ago",
                                isCurrent: false
                            )
                        }
                    }
                    
                    // Sign Out All Devices
                    Button(action: {
                        // Handle sign out all
                    }) {
                        Text("Sign Out All Other Devices")
                            .font(.DIN())
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.customRed)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.white)
        }
        .background(Color.white)
        .alert("Password Updated", isPresented: $showPasswordSuccess) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your password has been successfully updated.")
        }
    }
}

// MARK: - Active Session Card
struct ActiveSessionCard: View {
    let deviceName: String
    let location: String
    let lastActive: String
    let isCurrent: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.lightBlue.opacity(0.15))
                    .frame(width: 40, height: 40)
                
                Image(systemName: deviceName.contains("iPad") ? "ipad" : "iphone")
                    .font(.system(size: 18))
                    .foregroundStyle(.lightBlue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(deviceName)
                        .font(.DIN())
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    if isCurrent {
                        Text("CURRENT")
                            .font(.DIN(size: 10))
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.green.opacity(0.15))
                            .cornerRadius(4)
                    }
                }
                
                Text(location)
                    .font(.DIN(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.5))
                
                Text("Last active: \(lastActive)")
                    .font(.DIN(size: 12))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.4))
            }
            
            Spacer()
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black.opacity(0.1), lineWidth: 2)
        )
    }
}

#Preview {
    SecuritySettingsView()
}

