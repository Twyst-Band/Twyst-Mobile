//
//  EditBodyProfileView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct EditBodyProfileView: View {
    @Environment(\.dismiss) var dismiss
    let profile: BodyProfile
    @State private var profileName: String = ""
    @State private var height: String = ""
    @State private var armLength: String = ""
    @State private var legLength: String = ""
    @State private var torsoLength: String = ""
    @State private var isActive: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 20) {
                        LabeledTextField(label: "Profile Name", placeholder: "e.g., Default Profile", text: $profileName)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Height (cm)")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextField("175", text: $height)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .keyboardType(.numberPad)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Arm Length (cm)")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextField("65", text: $armLength)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .keyboardType(.numberPad)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Leg Length (cm)")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextField("92", text: $legLength)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .keyboardType(.numberPad)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Torso Length (cm)")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            TextField("58", text: $torsoLength)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.7))
                                .keyboardType(.numberPad)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                        }
                        
                        // Active Toggle
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Set as Active Profile")
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                                
                                Text("This profile will be used for all exercises")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            
                            Spacer()
                            
                            Toggle("", isOn: $isActive)
                                .labelsHidden()
                                .tint(.lightBlue)
                        }
                        .padding()
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
                    
                    // Delete Profile Button
                    Button(action: {
                        showDeleteAlert = true
                    }) {
                        Text("Delete Profile")
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
        .onAppear {
            profileName = profile.name
            height = "\(profile.height)"
            armLength = "\(profile.armLength)"
            legLength = "\(profile.legLength)"
            torsoLength = "\(profile.torsoLength)"
            isActive = profile.isActive
        }
        .alert("Delete Profile", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                // Handle delete
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this body profile? This action cannot be undone.")
        }
    }
}

#Preview {
    EditBodyProfileView(profile: BodyProfile(
        name: "Default Profile",
        height: 175,
        armLength: 65,
        legLength: 92,
        torsoLength: 58,
        isActive: true,
        lastUpdated: "2 weeks ago"
    ))
}

