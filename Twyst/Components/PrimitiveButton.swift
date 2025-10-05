//
//  PrimitiveButton.swift
//  Twyst
//
//  Created by Karo on 04.10.2025.
//

import SwiftUI

enum ButtonType {
    case primary
    case secondary
    case tertiary
}

struct PrimitiveButton: View {
    var content: String;
    var type: ButtonType;
    var action: () -> Void;
    
    var body: some View {
        Button(action: action) {
            Text(content)
                .font(.DIN())
                .fontWeight(.bold)
                .foregroundColor(foregroundColor)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
        }
    }
    
    private var backgroundColor: Color {
        switch type {
        case .primary: return .lightBlue
        case .secondary: return .white
        case .tertiary: return .clear
        }
    }
    
    private var foregroundColor: Color {
        switch type {
        case .primary: return .white
        case .secondary: return .lightBlue
        case .tertiary: return .customRed
        }
    }
    
    private var borderColor: Color {
        switch type {
        case .secondary: return .lightGray
        default: return .clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch type {
        case .secondary: return 2
        default: return 0
        }
    }
}

#Preview {
    PrimitiveButton(content: "Log In", type: .secondary) {
        print("Test")
    }.padding(.horizontal)
}
