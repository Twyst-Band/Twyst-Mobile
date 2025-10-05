//
//  PrivacyPolicyView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Privacy Policy")
                        .font(.DIN(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("Last updated: October 5, 2025")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                    
                    PolicySection(
                        title: "Information We Collect",
                        content: "We collect information you provide directly to us, such as when you create an account, use our services, or communicate with us. This includes your name, email address, profile information, body measurements, and workout data."
                    )
                    
                    PolicySection(
                        title: "How We Use Your Information",
                        content: "We use the information we collect to provide, maintain, and improve our services, including to track your fitness progress, provide personalized workout recommendations, and connect you with other users."
                    )
                    
                    PolicySection(
                        title: "Information Sharing",
                        content: "We do not share your personal information with third parties except as described in this policy. We may share your information with service providers who perform services on our behalf, such as hosting and analytics."
                    )
                    
                    PolicySection(
                        title: "Body Measurement Data",
                        content: "Your body measurements are stored securely and used solely to provide accurate motion tracking during exercises. This data is encrypted and never shared with third parties without your explicit consent."
                    )
                    
                    PolicySection(
                        title: "Bandana Device Data",
                        content: "Data collected by Twyst bandanas, including motion data and workout metrics, is processed locally on your device and synced to our secure servers. You maintain full control over this data and can delete it at any time."
                    )
                    
                    PolicySection(
                        title: "Your Rights",
                        content: "You have the right to access, update, or delete your personal information. You can also request a copy of your data or object to certain processing activities. Contact us at privacy@twyst.com to exercise these rights."
                    )
                    
                    PolicySection(
                        title: "Data Security",
                        content: "We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction."
                    )
                    
                    PolicySection(
                        title: "Children's Privacy",
                        content: "Our services are not intended for children under 13. We do not knowingly collect personal information from children under 13. If you believe we have collected such information, please contact us immediately."
                    )
                    
                    PolicySection(
                        title: "Changes to This Policy",
                        content: "We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page and updating the 'Last updated' date."
                    )
                    
                    PolicySection(
                        title: "Contact Us",
                        content: "If you have any questions about this privacy policy, please contact us at:\n\nEmail: privacy@twyst.com\nAddress: 123 Fitness Ave, San Francisco, CA 94102"
                    )
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Privacy Policy")
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

// MARK: - Policy Section Component
struct PolicySection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.DIN(size: 18))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.7))
            
            Text(content)
                .font(.DIN())
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.6))
                .lineSpacing(4)
        }
    }
}

#Preview {
    PrivacyPolicyView()
}

