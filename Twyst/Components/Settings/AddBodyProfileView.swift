//
//  AddBodyProfileView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct AddBodyProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var profileName: String = ""
    @State private var height: String = ""
    @State private var armLength: String = ""
    @State private var legLength: String = ""
    @State private var torsoLength: String = ""
    @State private var measurementMethod: MeasurementMethod = .manual
    
    enum MeasurementMethod {
        case manual
        case camera
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Measurement Method Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Measurement Method")
                            .font(.DIN(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                measurementMethod = .camera
                            }) {
                                VStack(spacing: 12) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 32))
                                        .foregroundStyle(measurementMethod == .camera ? .lightBlue : .black.opacity(0.4))
                                    
                                    Text("Use Camera")
                                        .font(.DIN(size: 14))
                                        .fontWeight(.bold)
                                        .foregroundStyle(measurementMethod == .camera ? .lightBlue : .black.opacity(0.6))
                                    
                                    Text("2 minutes")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(measurementMethod == .camera ? .lightBlue.opacity(0.1) : .white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(measurementMethod == .camera ? .lightBlue : .black.opacity(0.1), lineWidth: measurementMethod == .camera ? 3 : 2)
                                )
                            }
                            
                            Button(action: {
                                measurementMethod = .manual
                            }) {
                                VStack(spacing: 12) {
                                    Image(systemName: "pencil.and.ruler.fill")
                                        .font(.system(size: 32))
                                        .foregroundStyle(measurementMethod == .manual ? .lightBlue : .black.opacity(0.4))
                                    
                                    Text("Enter Manually")
                                        .font(.DIN(size: 14))
                                        .fontWeight(.bold)
                                        .foregroundStyle(measurementMethod == .manual ? .lightBlue : .black.opacity(0.6))
                                    
                                    Text("Quick")
                                        .font(.DIN(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(measurementMethod == .manual ? .lightBlue.opacity(0.1) : .white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(measurementMethod == .manual ? .lightBlue : .black.opacity(0.1), lineWidth: measurementMethod == .manual ? 3 : 2)
                                )
                            }
                        }
                    }
                    
                    if measurementMethod == .manual {
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
                        }
                        
                        PrimitiveButton(content: "Save Profile", type: .primary) {
                            // Handle save
                            dismiss()
                        }
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "camera.metering.center.weighted")
                                .font(.system(size: 80))
                                .foregroundStyle(.lightBlue.opacity(0.3))
                                .padding(.vertical, 40)
                            
                            Text("Camera Measurement")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            Text("Position yourself in front of the camera and follow the on-screen instructions. This will take approximately 2 minutes.")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(.black.opacity(0.6))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            PrimitiveButton(content: "Start Camera Scan", type: .primary) {
                                // Handle camera scan
                            }
                        }
                        .padding(.vertical, 40)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Add Body Profile")
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
    AddBodyProfileView()
}

