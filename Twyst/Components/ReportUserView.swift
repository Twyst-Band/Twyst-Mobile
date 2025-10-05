//
//  ReportUserView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ReportUserView: View {
    @Environment(\.dismiss) var dismiss
    let username: String
    
    @State private var selectedReason: String? = nil
    @State private var additionalInfo: String = ""
    @State private var showConfirmation: Bool = false
    
    let reportReasons = [
        "Spam or misleading content",
        "Inappropriate behavior",
        "Harassment or bullying",
        "Fake account",
        "Offensive content",
        "Other"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header with back button
            VStack(spacing: 0) {
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
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 12)
                .background(Color.white)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Report @\(username)")
                            .font(.DIN(size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Text("Help us understand what's happening. Your report is anonymous.")
                            .font(.DIN())
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    
                    // Reason selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Reason")
                            .font(.DIN(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        ForEach(reportReasons, id: \.self) { reason in
                            Button(action: {
                                selectedReason = reason
                            }) {
                                HStack {
                                    Text(reason)
                                        .font(.DIN())
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Spacer()
                                    
                                    if selectedReason == reason {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.lightBlue)
                                            .font(.system(size: 24))
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundStyle(.black.opacity(0.2))
                                            .font(.system(size: 24))
                                    }
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightGray, lineWidth: 2)
                                )
                            }
                        }
                    }
                    
                    // Additional info
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Additional Information (Optional)")
                            .font(.DIN(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        TextEditor(text: $additionalInfo)
                            .font(.DIN())
                            .frame(height: 120)
                            .padding(8)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightGray, lineWidth: 2)
                            )
                    }
                    
                    // Submit button
                    PrimitiveButton(
                        content: "Submit Report",
                        type: selectedReason != nil ? .primary : .secondary
                    ) {
                        if selectedReason != nil {
                            showConfirmation = true
                        }
                    }
                    .disabled(selectedReason == nil)
                    .padding(.top)
                }
                .padding()
            }
        }
        .background(Color.white)
        .alert("Report Submitted", isPresented: $showConfirmation) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Thank you for your report. We'll review it and take appropriate action if necessary.")
        }
    }
}

#Preview {
    ReportUserView(username: "testuser")
}

