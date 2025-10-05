//
//  LoginView.swift
//  Twyst
//
//  Created by Karo on 04.10.2025.
//

import SwiftUI

struct RegisterView: View {
    var onSuccess: () -> Void
    var onBack: () -> Void

    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""

    var body: some View {
        VStack(spacing: 45) {
            Text("Register").font(.DIN(size: 36)).fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.7))

            VStack(spacing: 10) {
                LabeledTextField(
                    label: "Username",
                    placeholder: "Eg. Twysty123",
                    text: $username
                )
                
                LabeledTextField(
                    label: "Email",
                    placeholder: "Ex. fox@twyst.com",
                    text: $email
                )

                LabeledTextField(
                    label: "Password",
                    placeholder: "A strong password",
                    text: $password,
                    password: true
                )
                
                LabeledTextField(
                    label: "Repeat password",
                    placeholder: "Repeat password",
                    text: $repeatPassword,
                    password: true
                )
            }

            VStack(spacing: 16) {
                PrimitiveButton(content: "Register", type: .primary) {
                    onSuccess()
                }

                HStack {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.black.opacity(0.2))

                    Text("Or continue with")
                        .frame(maxWidth: .infinity).fixedSize(
                            horizontal: true, vertical: false
                        ).lineLimit(1).padding(.horizontal).foregroundStyle(.black.opacity(0.2)).font(.DIN(size: 16)).fontWeight(.bold)

                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.black.opacity(0.2))
                }
                
                HStack(spacing: 12) {
                    PrimitiveButton(content: "Google", type: .secondary) {
                        
                    }
                    
                    PrimitiveButton(content: "Apple", type: .secondary) {
                        
                    }
                }
            }
        }.padding(.horizontal)
    }
}

#Preview {
    RegisterView(onSuccess: {}, onBack: {})
}
