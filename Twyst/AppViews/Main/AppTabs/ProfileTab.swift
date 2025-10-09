//
//  ProfileTab.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct ProfileTab: View {
    @State private var showSettings: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showSettings = true
                        }) {
                            Image(systemName: "gearshape").font(.system(size: 24))
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        .padding(.trailing).padding(.top)
                    }
                    
                    Spacer()
                    Image("profile-pic").resizable().scaledToFit()
                        .frame(maxWidth: 200)
                }.ignoresSafeArea()
                    .frame(height: 316)
                    .frame(maxWidth: .infinity)
                    .background {
                        Image("login-bg").resizable()
                            .scaledToFill()
                            .frame(minWidth: 800).frame(
                                width: UIScreen.main.bounds.width, height: 316
                            )
                            .clipped()
                    }
                    .padding(.top, geometry.safeAreaInsets.top)
                    .background(
                        .lightBlue.opacity(0.6))
                
                VStack(alignment: .leading) {
                    VStack {
                        Text("Twyst").font(.DIN(size: 24)).fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7)).frame(
                                maxWidth: .infinity, alignment: .leading)
                        
                        Text("@EmilySusan · Joined September 2025").font(.DIN())
                            .fontWeight(.regular)
                            .foregroundStyle(.black.opacity(0.7)).frame(
                                maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"
                    ).frame(
                        maxWidth: .infinity, alignment: .leading
                    ).font(.DIN()).fontWeight(.medium).padding(.top, 8)
                        .foregroundStyle(.black.opacity(0.6))
                    
                    HStack(spacing: 18) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "dumbbell.fill").resizable().scaledToFit().padding(3.5).frame(width: 32, height: 22).overlay(
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(.goldYellow, lineWidth: 2)
                                ).foregroundStyle(.goldYellow)
                                
                                Text("+4").font(.DIN(size: 14)).fontWeight(.bold).foregroundStyle(.black.opacity(0.3)).padding(3.5).frame(width: 32, height: 22).overlay(
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(.black.opacity(0.3), lineWidth: 2)
                                )
                            }
                            
                            Text("Courses").font(.DIN())
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Rectangle().frame(width: 2, height: 40).foregroundStyle(.black.opacity(0.1))
                        
                        VStack(alignment: .leading) {
                            Text("27").font(.DIN(size: 20)).bold()
                            
                            Text("Followers").font(.DIN())
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Rectangle().frame(width: 2, height: 40).foregroundStyle(.black.opacity(0.1))
                        
                        VStack(alignment: .leading) {
                            Text("27").font(.DIN(size: 20)).bold()
                            
                            Text("Following").font(.DIN())
                                .fontWeight(.regular)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                    }.padding(.top)
                    
                    PrimitiveButton(content: "+ Add friends", type: .secondary) {
                        
                    }.padding(.top)
                    
                    Text("Overview").font(.DIN(size: 24)).fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.7)).frame(
                            maxWidth: .infinity, alignment: .leading).padding(.top)
                    
                    HStack {
                        StatBox(value: "102", description: "Day streak") {
                            Image(systemName: "flame.fill").foregroundStyle(.orange).font(.system(size: 24))
                        }
                        
                        StatBox(value: "89%", description: "Avg. accuracy") {
                            Image(systemName: "percent").foregroundStyle(.green).bold().font(.system(size: 24))
                        }
                    }
                    
                    HStack {
                        StatBox(value: "4527 XP", description: "Total XP") {
                            Image(systemName: "sparkles").foregroundStyle(.goldYellow).font(.system(size: 24))
                        }
                        
                        StatBox(value: "24", description: "Gym score") {
                            Image(systemName: "dumbbell.fill").foregroundStyle(.gray60).font(.system(size: 24)).bold()
                        }
                    }
                    
                    
                }.frame(maxWidth: .infinity).padding(.horizontal)
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .top)
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    ProfileTab()
}
