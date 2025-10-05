//
//  BodyProfilesView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct BodyProfilesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showAddProfile: Bool = false
    @State private var selectedProfile: BodyProfile? = nil
    
    // Mock body profiles
    let bodyProfiles: [BodyProfile] = [
        BodyProfile(
            name: "Default Profile",
            height: 175,
            armLength: 65,
            legLength: 92,
            torsoLength: 58,
            isActive: true,
            lastUpdated: "2 weeks ago"
        ),
        BodyProfile(
            name: "Winter Training",
            height: 175,
            armLength: 66,
            legLength: 92,
            torsoLength: 59,
            isActive: false,
            lastUpdated: "3 months ago"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Info Banner
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.lightBlue)
                            
                            Text("Why Body Profiles?")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Text("Accurate body measurements help Twyst track your movements precisely. Update your profile if your measurements change.")
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                            .lineSpacing(4)
                    }
                    .padding()
                    .background(.lightBlue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Body Profiles List
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Profiles")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(.horizontal)
                        
                        ForEach(bodyProfiles) { profile in
                            Button(action: {
                                selectedProfile = profile
                            }) {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack(spacing: 8) {
                                                Text(profile.name)
                                                    .font(.DIN(size: 18))
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.black.opacity(0.7))
                                                
                                                if profile.isActive {
                                                    Text("ACTIVE")
                                                        .font(.DIN(size: 10))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.green)
                                                        .padding(.horizontal, 8)
                                                        .padding(.vertical, 4)
                                                        .background(.green.opacity(0.15))
                                                        .cornerRadius(4)
                                                }
                                            }
                                            
                                            Text("Updated \(profile.lastUpdated)")
                                                .font(.DIN(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundStyle(.black.opacity(0.5))
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14))
                                            .foregroundStyle(.black.opacity(0.3))
                                    }
                                    
                                    // Measurements Preview
                                    HStack(spacing: 16) {
                                        MeasurementPreview(icon: "figure.stand", label: "Height", value: "\(profile.height) cm")
                                        MeasurementPreview(icon: "ruler", label: "Arms", value: "\(profile.armLength) cm")
                                        MeasurementPreview(icon: "ruler", label: "Legs", value: "\(profile.legLength) cm")
                                        MeasurementPreview(icon: "rectangle.portrait", label: "Torso", value: "\(profile.torsoLength) cm")
                                    }
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(profile.isActive ? .lightBlue : .black.opacity(0.1), lineWidth: profile.isActive ? 3 : 2)
                                )
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Add New Profile Button
                    Button(action: {
                        showAddProfile = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.lightBlue)
                            
                            Text("Add New Profile")
                                .font(.DIN())
                                .fontWeight(.bold)
                                .foregroundStyle(.lightBlue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.lightBlue, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .background(Color.white)
            .navigationTitle("Body Profiles")
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
        .fullScreenCover(isPresented: $showAddProfile) {
            AddBodyProfileView()
        }
        .fullScreenCover(item: $selectedProfile) { profile in
            EditBodyProfileView(profile: profile)
        }
    }
}

// MARK: - Measurement Preview Component
struct MeasurementPreview: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(.lightBlue)
            
            Text(value)
                .font(.DIN(size: 12))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.7))
            
            Text(label)
                .font(.DIN(size: 10))
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Body Profile Model
struct BodyProfile: Identifiable {
    let id = UUID()
    let name: String
    let height: Int
    let armLength: Int
    let legLength: Int
    let torsoLength: Int
    let isActive: Bool
    let lastUpdated: String
}

#Preview {
    BodyProfilesView()
}

