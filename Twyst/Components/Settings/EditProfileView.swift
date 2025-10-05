//
//  EditProfileView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = "Twyst"
    @State private var username: String = "EmilySusan"
    @State private var bio: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Picture Section
                    VStack(spacing: 16) {
                        Image("profile-pic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(.lightBlue, lineWidth: 3)
                            )
                        
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Text("Change Photo")
                                .font(.DIN())
                                .fontWeight(.bold)
                                .foregroundStyle(.lightBlue)
                        }
                    }
                    .padding(.vertical)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        LabeledTextField(label: "Display Name", placeholder: "Enter your name", text: $name)
                        
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
                            Text("Bio")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextEditor(text: $bio)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .frame(height: 100)
                                .padding(8)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                    }
                    
                    PrimitiveButton(content: "Save Changes", type: .primary) {
                        // Handle save
                        dismiss()
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Edit Profile")
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

#Preview {
    EditProfileView()
}

