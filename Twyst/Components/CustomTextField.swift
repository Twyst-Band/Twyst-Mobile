//
//  Input.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var password: Bool = false

    @State private var showPassword: Bool = false

    var body: some View {
        HStack {
            if !password || showPassword {
                TextField(placeholder, text: $text).font(.DIN())
                    .fontWeight(.medium)
            } else {
                SecureField(placeholder, text: $text).font(.DIN())
                    .fontWeight(.medium)
            }

            if password {
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
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

#Preview {
    @Previewable @State var value: String = ""

    CustomTextField(placeholder: "Search", text: $value, password: true)
        .padding(.horizontal)
}
