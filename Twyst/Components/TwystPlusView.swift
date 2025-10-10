//
//  TwystPlusView.swift
//  Twyst
//
//  Created by Karo on 10.10.2025.
//

import SwiftUI

struct TwystPlusView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedPlan: SubscriptionPlan = .monthly
    @State private var showPurchaseSuccess: Bool = false
    
    enum SubscriptionPlan {
        case monthly
        case yearly
        
        var price: String {
            switch self {
            case .monthly: return "$9.99"
            case .yearly: return "$99.99"
            }
        }
        
        var period: String {
            switch self {
            case .monthly: return "month"
            case .yearly: return "year"
            }
        }
        
        var savings: String? {
            switch self {
            case .monthly: return nil
            case .yearly: return "Save $19.89"
            }
        }
    }
    
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
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 12)
            .background(Color.white)
            
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Section
                    VStack(spacing: 16) {
                        // Premium Icon
                        ZStack {
                            Circle()
                                .fill(.goldYellow.opacity(0.15))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "crown.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.goldYellow)
                        }
                        
                        Text("Twyst Plus")
                            .font(.DIN(size: 32))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Text("Unlock your full potential")
                            .font(.DIN(size: 18))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    .padding(.top, 20)
                    
                    // Features List
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Premium Features")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            FeatureRow(
                                icon: "infinity",
                                iconColor: .lightBlue,
                                title: "Unlimited Exercises",
                                description: "Access all premium exercises and challenges"
                            )
                            
                            FeatureRow(
                                icon: "chart.line.uptrend.xyaxis",
                                iconColor: .green,
                                title: "Advanced Analytics",
                                description: "Detailed performance insights and progress tracking"
                            )
                            
                            FeatureRow(
                                icon: "person.3.fill",
                                iconColor: .orange,
                                title: "Group Challenges",
                                description: "Join exclusive community challenges"
                            )
                            
                            FeatureRow(
                                icon: "video.fill",
                                iconColor: .customRed,
                                title: "Video Guides",
                                description: "Professional form demonstrations and tutorials"
                            )
                            
                            FeatureRow(
                                icon: "sparkles",
                                iconColor: .goldYellow,
                                title: "2x XP Boost",
                                description: "Earn double experience points on all exercises"
                            )
                            
                            FeatureRow(
                                icon: "calendar.badge.plus",
                                iconColor: .lightBlue,
                                title: "Custom Programs",
                                description: "Create and save personalized workout plans"
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    // Subscription Plans
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Choose Your Plan")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            // Yearly Plan
                            PlanCard(
                                plan: .yearly,
                                isSelected: selectedPlan == .yearly,
                                onSelect: { selectedPlan = .yearly }
                            )
                            
                            // Monthly Plan
                            PlanCard(
                                plan: .monthly,
                                isSelected: selectedPlan == .monthly,
                                onSelect: { selectedPlan = .monthly }
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    // Subscribe Button
                    VStack(spacing: 12) {
                        PrimitiveButton(
                            content: "Start Free Trial",
                            type: .primary
                        ) {
                            showPurchaseSuccess = true
                        }
                        .padding(.horizontal)
                        
                        Text("7 days free, then \(selectedPlan.price)/\(selectedPlan.period)")
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                        
                        Text("Cancel anytime • No commitment")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.4))
                    }
                    .padding(.top)
                    
                    // Fine Print
                    VStack(spacing: 8) {
                        Text("Terms & Conditions")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(.lightBlue)
                        
                        Text("Subscription automatically renews unless cancelled at least 24 hours before the end of the current period. Manage your subscription in Account Settings.")
                            .font(.DIN(size: 10))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.4))
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top)
                    
                    Spacer()
                        .frame(height: 20)
                }
            }
            .background(Color.white)
        }
        .background(Color.white)
        .alert("Welcome to Twyst Plus! 🎉", isPresented: $showPurchaseSuccess) {
            Button("Start Using Plus") {
                dismiss()
            }
        } message: {
            Text("Your 7-day free trial has started. Enjoy unlimited access to all premium features!")
        }
    }
}

// MARK: - Feature Row
struct FeatureRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.DIN(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Text(description)
                    .font(.DIN(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.6))
                    .lineSpacing(2)
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

// MARK: - Plan Card
struct PlanCard: View {
    let plan: TwystPlusView.SubscriptionPlan
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text(plan.period.capitalized)
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            if let savings = plan.savings {
                                Text(savings)
                                    .font(.DIN(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.green.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }
                        
                        Text("\(plan.price) per \(plan.period)")
                            .font(.DIN(size: 14))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    
                    Spacer()
                    
                    // Selection indicator
                    ZStack {
                        Circle()
                            .stroke(isSelected ? .lightBlue : .black.opacity(0.2), lineWidth: 2)
                            .frame(width: 28, height: 28)
                        
                        if isSelected {
                            Circle()
                                .fill(.lightBlue)
                                .frame(width: 16, height: 16)
                        }
                    }
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? .lightBlue : .black.opacity(0.1), lineWidth: isSelected ? 3 : 2)
            )
        }
    }
}

#Preview {
    TwystPlusView()
}

