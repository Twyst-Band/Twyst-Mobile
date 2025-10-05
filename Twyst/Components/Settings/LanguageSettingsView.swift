//
//  LanguageSettingsView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct LanguageSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedLanguage: String = "English"
    
    let languages: [Language] = [
        Language(code: "en", name: "English", nativeName: "English"),
        Language(code: "es", name: "Spanish", nativeName: "Español"),
        Language(code: "fr", name: "French", nativeName: "Français"),
        Language(code: "de", name: "German", nativeName: "Deutsch"),
        Language(code: "it", name: "Italian", nativeName: "Italiano"),
        Language(code: "pt", name: "Portuguese", nativeName: "Português"),
        Language(code: "ja", name: "Japanese", nativeName: "日本語"),
        Language(code: "ko", name: "Korean", nativeName: "한국어"),
        Language(code: "zh", name: "Chinese", nativeName: "中文"),
        Language(code: "ar", name: "Arabic", nativeName: "العربية")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(languages) { language in
                        Button(action: {
                            selectedLanguage = language.name
                        }) {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(language.name)
                                        .font(.DIN(size: 16))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Text(language.nativeName)
                                        .font(.DIN(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.5))
                                }
                                
                                Spacer()
                                
                                if selectedLanguage == language.name {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundStyle(.lightBlue)
                                }
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedLanguage == language.name ? .lightBlue : .black.opacity(0.1), lineWidth: selectedLanguage == language.name ? 3 : 2)
                            )
                        }
                    }
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Language")
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

// MARK: - Language Model
struct Language: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let nativeName: String
}

#Preview {
    LanguageSettingsView()
}

