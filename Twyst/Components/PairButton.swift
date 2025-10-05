//
//  PairButton.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct PairButton: View {
    var id: String;
    var version: String;
    var bandanaCount: Int;
    var paired: Bool;
    
    var action: () -> Void;
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image("bandana-md").resizable().scaledToFit().frame(maxWidth: 32)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Text("ID:").font(.DIN(size: 20)).foregroundStyle(foregroundColor).fontWeight(.medium)
                        Text(id).font(.DIN(size: 20)).foregroundStyle(foregroundColor).fontWeight(.bold)
                    }
                    
                    HStack(spacing: 4) {
                        Text("Version:").font(.DIN(size: 20)).foregroundStyle(foregroundColor).fontWeight(.medium)
                        Text(version).font(.DIN(size: 20)).foregroundStyle(foregroundColor).fontWeight(.bold)
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text("Paired").font(.DIN(size: 20)).foregroundStyle(.white).fontWeight(.medium)
                
                HStack(spacing: 2) {
                    Text("\(bandanaCount) x").font(.DIN(size: 20)).foregroundStyle(foregroundColor).fontWeight(.medium)
                    Image("bandana-sm").resizable().scaledToFit().frame(maxHeight: 24)
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading).padding().background(backgroundColor).cornerRadius(12).overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: borderWidth)
        }
    }
    
    private var backgroundColor: Color {
        paired ? .lightBlue : .white
    }
    
    private var foregroundColor: Color {
        paired ? .white : .black.opacity(0.5)
    }
    
    private var borderColor: Color {
        paired ? .clear : .lightGray
    }
    
    private var borderWidth: CGFloat {
        paired ? 0 : 2
    }
}

#Preview {
    PairButton(id: "aSzk54Hjmy68", version: "Twyst-1.3", bandanaCount: 4, paired: true) {
        
    }
}
