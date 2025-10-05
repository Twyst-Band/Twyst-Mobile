//
//  TermsOfServiceView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Terms of Service")
                        .font(.DIN(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    Text("Last updated: October 5, 2025")
                        .font(.DIN(size: 14))
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.5))
                    
                    PolicySection(
                        title: "Acceptance of Terms",
                        content: "By accessing and using Twyst, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to these terms, please do not use our services."
                    )
                    
                    PolicySection(
                        title: "Use License",
                        content: "Permission is granted to temporarily use Twyst for personal, non-commercial use only. This license shall automatically terminate if you violate any of these restrictions."
                    )
                    
                    PolicySection(
                        title: "User Account",
                        content: "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account."
                    )
                    
                    PolicySection(
                        title: "Twyst Bandana Devices",
                        content: "Twyst bandana devices are provided for fitness tracking purposes only. You are responsible for the proper use and care of the devices. Any damage or loss may result in charges to your account."
                    )
                    
                    PolicySection(
                        title: "Health and Safety",
                        content: "Twyst is a fitness application and should not replace professional medical advice. Consult with a healthcare provider before starting any new exercise program. Use Twyst at your own risk."
                    )
                    
                    PolicySection(
                        title: "User Content",
                        content: "You retain all rights to any content you submit, post, or display on or through Twyst. By posting content, you grant us a worldwide, non-exclusive, royalty-free license to use, copy, reproduce, process, adapt, and publish your content."
                    )
                    
                    PolicySection(
                        title: "Prohibited Uses",
                        content: "You may not use Twyst for any illegal purpose or to violate any laws. You may not attempt to gain unauthorized access to any portion of the service or any systems or networks connected to the service."
                    )
                    
                    PolicySection(
                        title: "Subscription and Payments",
                        content: "Some features of Twyst require a paid subscription. Subscription fees are billed in advance on a recurring basis. You may cancel your subscription at any time, but no refunds will be provided for partial periods."
                    )
                    
                    PolicySection(
                        title: "Termination",
                        content: "We may terminate or suspend your account and bar access to the service immediately, without prior notice or liability, for any reason, including breach of these Terms."
                    )
                    
                    PolicySection(
                        title: "Limitation of Liability",
                        content: "In no event shall Twyst, its directors, employees, or agents be liable for any indirect, incidental, special, consequential, or punitive damages arising out of your use of the service."
                    )
                    
                    PolicySection(
                        title: "Changes to Terms",
                        content: "We reserve the right to modify these terms at any time. We will notify users of any changes by updating the 'Last updated' date. Your continued use of Twyst after changes constitutes acceptance of the new terms."
                    )
                    
                    PolicySection(
                        title: "Contact Information",
                        content: "If you have any questions about these Terms, please contact us at:\n\nEmail: legal@twyst.com\nAddress: 123 Fitness Ave, San Francisco, CA 94102"
                    )
                    
                    Spacer()
                        .frame(height: 40)
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Terms of Service")
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
    TermsOfServiceView()
}

