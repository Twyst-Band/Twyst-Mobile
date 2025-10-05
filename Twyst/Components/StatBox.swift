//
//  StatBox.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct StatBox<Content: View>: View {
    let value: String
    let description: String
    
    let content: () -> Content

    init(value: String, description: String, @ViewBuilder content: @escaping () -> Content) {
        self.value = value
        self.description = description
        
        self.content = content
    }

    var body: some View {
        HStack {
            content()
            
            VStack(alignment: .leading) {
                Text(value).font(.DIN(size: 20)).bold()
                
                Text(description).font(.DIN()).fontWeight(.medium).foregroundStyle(.black.opacity(0.5))
            }
            
            Spacer()
        }.cornerRadius(10)
            .frame(maxWidth: .infinity)
            .padding(12)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black.opacity(0.1), lineWidth: 2)
            )
    }
}


#Preview {
    StatBox(value: "4527 XP", description: "Total XP") {
        Image(systemName: "sparkles").foregroundStyle(.goldYellow).font(.system(size: 24))
    }
}
