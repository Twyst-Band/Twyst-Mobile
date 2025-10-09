//
//  AccountSettingsView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct AccountSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email: String = "emily.susan@example.com"
    @State private var username: String = "EmilySusan"
    @State private var phoneNumber: String = "+1 (555) 123-4567"
    @State private var showDeleteAccountAlert: Bool = false
    
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
                
                Text("Account Settings")
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
                    // Account Information
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Account Information")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email Address")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextField("", text: $email)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            HStack {
                                Text("@")
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                                
                                TextField("", text: $username)
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.7))
                                    .autocapitalization(.none)
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightGray, lineWidth: 2)
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone Number")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextField("", text: $phoneNumber)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .keyboardType(.phonePad)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                    }
                    
                    // Account Stats
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Account Stats")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text("Member Since")
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                Spacer()
                                
                                Text("September 2025")
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            .padding()
                            
                            Divider()
                            
                            HStack {
                                Text("Total Workouts")
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                Spacer()
                                
                                Text("127")
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            .padding()
                            
                            Divider()
                            
                            HStack {
                                Text("Account Type")
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                Spacer()
                                
                                Text("Premium")
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.goldYellow)
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
                    
                    PrimitiveButton(content: "Save Changes", type: .primary) {
                        // Handle save
                        dismiss()
                    }
                    
                    // Danger Zone
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Danger Zone")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.customRed)
                        
                        Button(action: {
                            showDeleteAccountAlert = true
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Delete Account")
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text("Permanently delete your account and data")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.customRed)
                            .cornerRadius(12)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.white)
        }
        .background(Color.white)
        .alert("Delete Account", isPresented: $showDeleteAccountAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                // Handle account deletion
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.")
        }
    }
}

#Preview {
    AccountSettingsView()
}

