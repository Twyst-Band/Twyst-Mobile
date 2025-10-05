//
//  BandanaConnectionsView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct BandanaConnectionsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isScanning: Bool = false
    @State private var showPairNew: Bool = false
    
    // Mock connected devices
    @State private var connectedDevices: [BandanaDevice] = [
        BandanaDevice(id: "CfGu2ski2h1b", version: "Kid-1.2", bandanaCount: 6, isPaired: true, batteryLevel: 87, lastConnected: "2 minutes ago"),
        BandanaDevice(id: "aSzk54Hjmy68", version: "Twyst-1.3", bandanaCount: 4, isPaired: true, batteryLevel: 45, lastConnected: "1 day ago")
    ]
    
    // Available devices
    let availableDevices: [BandanaDevice] = [
        BandanaDevice(id: "Xa12QEr7HqM5", version: "Pro-1.0", bandanaCount: 4, isPaired: false, batteryLevel: nil, lastConnected: nil)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Info Banner
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image("bandana-sm")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                            
                            Text("About Bandanas")
                                .font(.DIN(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Text("Twyst bandanas track your body movements during exercises. Keep them charged and connected for accurate tracking.")
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                            .lineSpacing(4)
                    }
                    .padding()
                    .background(.lightBlue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Connected Devices
                    if !connectedDevices.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Connected Devices")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                                .padding(.horizontal)
                            
                            ForEach(connectedDevices) { device in
                                BandanaDeviceCard(device: device, onDisconnect: {
                                    // Handle disconnect
                                })
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Scan for Devices
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Available Devices")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(.horizontal)
                        
                        if isScanning {
                            VStack(spacing: 16) {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(.lightBlue)
                                
                                Text("Scanning for devices...")
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.black.opacity(0.1), lineWidth: 2)
                            )
                            .padding(.horizontal)
                        } else if availableDevices.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "wifi.slash")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.black.opacity(0.3))
                                
                                Text("No devices found")
                                    .font(.DIN())
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                Text("Make sure your Twyst devices are powered on")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.black.opacity(0.1), lineWidth: 2)
                            )
                            .padding(.horizontal)
                        } else {
                            ForEach(availableDevices) { device in
                                PairButton(
                                    id: device.id,
                                    version: device.version,
                                    bandanaCount: device.bandanaCount,
                                    paired: false
                                ) {
                                    // Handle pairing
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Scan Button
                    Button(action: {
                        isScanning = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isScanning = false
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 18))
                                .foregroundStyle(.lightBlue)
                            
                            Text("Scan for Devices")
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
                    .disabled(isScanning)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .background(Color.white)
            .navigationTitle("Bandana Connections")
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

// MARK: - Bandana Device Card
struct BandanaDeviceCard: View {
    let device: BandanaDevice
    let onDisconnect: () -> Void
    @State private var showDisconnectAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image("bandana-sm")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(device.version)
                        .font(.DIN(size: 18))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("ID: \(device.id)")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
                
                Spacer()
                
                if device.isPaired {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.green)
                }
            }
            
            // Device Stats
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "battery.75")
                        .font(.system(size: 14))
                        .foregroundStyle(batteryColor)
                    
                    Text("\(device.batteryLevel ?? 0)%")
                        .font(.DIN(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                }
                
                Text("•")
                    .foregroundStyle(.black.opacity(0.3))
                
                HStack(spacing: 4) {
                    Text("\(device.bandanaCount)")
                        .font(.DIN(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("bandanas")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                }
                
                Text("•")
                    .foregroundStyle(.black.opacity(0.3))
                
                Text(device.lastConnected ?? "Never")
                    .font(.DIN(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.5))
            }
            
            // Disconnect Button
            Button(action: {
                showDisconnectAlert = true
            }) {
                Text("Disconnect")
                    .font(.DIN(size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(.customRed)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(.customRed.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.lightBlue, lineWidth: 2)
        )
        .alert("Disconnect Device", isPresented: $showDisconnectAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Disconnect", role: .destructive) {
                onDisconnect()
            }
        } message: {
            Text("Are you sure you want to disconnect this device?")
        }
    }
    
    var batteryColor: Color {
        guard let battery = device.batteryLevel else { return .gray }
        if battery > 50 { return .green }
        if battery > 20 { return .orange }
        return .customRed
    }
}

// MARK: - Bandana Device Model
struct BandanaDevice: Identifiable {
    let id: String
    let version: String
    let bandanaCount: Int
    let isPaired: Bool
    let batteryLevel: Int?
    let lastConnected: String?
}

#Preview {
    BandanaConnectionsView()
}

