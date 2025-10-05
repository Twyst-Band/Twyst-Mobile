//
//  MainView.swift
//  Twyst
//
//  Created by Karo on 04.10.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TabView {
                PathTab()
                    .tabItem {
                        Image(systemName: "graduationcap")
                    }

                ProfileTab()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }

                LibraryTab()
                    .tabItem {
                        Image(systemName: "books.vertical")
                    }
                
                ResultsTab()
                    .tabItem {
                        Image(systemName: "trophy")
                    }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
