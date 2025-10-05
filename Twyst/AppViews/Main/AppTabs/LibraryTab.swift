//
//  LibraryTab.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

// MARK: - Full List Views
struct UsersListView: View {
    @Environment(\.dismiss) var dismiss
    let users: [(String, String, Int)]
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
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
                
                Text(title)
                    .font(.DIN(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Spacer()
                
                // Placeholder for symmetry
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                    Text("Back")
                        .font(.DIN())
                        .fontWeight(.medium)
                }
                .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(users, id: \.1) { user in
                        ClickableUserCard(name: user.0, username: user.1, followers: user.2)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

struct ExercisesListView: View {
    @Environment(\.dismiss) var dismiss
    let exercises: [(String, String, String, String)]
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
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
                
                Text(title)
                    .font(.DIN(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Spacer()
                
                // Placeholder for symmetry
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                    Text("Back")
                        .font(.DIN())
                        .fontWeight(.medium)
                }
                .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(exercises, id: \.0) { exercise in
                        ClickableExerciseCard(
                            title: exercise.0,
                            duration: exercise.1,
                            difficulty: exercise.2,
                            category: exercise.3,
                            isPurchased: true
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

struct PacksListView: View {
    @Environment(\.dismiss) var dismiss
    let packs: [(String, Int, String, String)]
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
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
                
                Text(title)
                    .font(.DIN(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                
                Spacer()
                
                // Placeholder for symmetry
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                    Text("Back")
                        .font(.DIN())
                        .fontWeight(.medium)
                }
                .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(packs, id: \.0) { pack in
                        ClickablePackCard(
                            title: pack.0,
                            itemCount: pack.1,
                            type: pack.2,
                            difficulty: pack.3
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

// MARK: - Search View
struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "All"
    @State private var showFilterSheet: Bool = false
    @State private var selectedDifficulty: Set<String> = []
    @State private var selectedDuration: String = "All"
    @State private var recentSearches: [String] = ["Push-ups", "Yoga Flow", "HIIT", "Core Workout"]
    @FocusState private var isSearchFocused: Bool
    
    @State private var showAllUsers: Bool = false
    @State private var showAllExercises: Bool = false
    @State private var showAllPacks: Bool = false
    @State private var showAllChallenges: Bool = false
    
    let filters = ["All", "Strength", "Cardio", "Flexibility", "Balance"]
    let difficulties = ["Beginner", "Intermediate", "Advanced"]
    let durations = ["All", "5-10 min", "10-20 min", "20+ min"]
    
    // Mock search data - imported from MockLibraryData
    let allUsers = MockLibraryData.allUsers
    let allExercises = MockLibraryData.allExercises
    let allPacks = MockLibraryData.allPacks
    let allChallenges = MockLibraryData.allChallenges
    
    var filteredUsers: [(String, String, Int)] {
        guard !searchText.isEmpty else { return [] }
        return allUsers.filter { user in
            user.0.lowercased().contains(searchText.lowercased()) ||
            user.1.lowercased().contains(searchText.lowercased())
        }
    }
    
    var filteredExercises: [(String, String, String, String)] {
        guard !searchText.isEmpty else { return [] }
        return allExercises.filter { exercise in
            let matchesSearch = exercise.0.lowercased().contains(searchText.lowercased())
            let matchesCategory = selectedFilter == "All" || exercise.3 == selectedFilter
            let matchesDifficulty = selectedDifficulty.isEmpty || selectedDifficulty.contains(exercise.2)
            
            let matchesDuration: Bool = {
                if selectedDuration == "All" { return true }
                let minutes = Int(exercise.1.split(separator: " ").first ?? "0") ?? 0
                switch selectedDuration {
                case "5-10 min": return minutes >= 5 && minutes <= 10
                case "10-20 min": return minutes > 10 && minutes <= 20
                case "20+ min": return minutes > 20
                default: return true
                }
            }()
            
            return matchesSearch && matchesCategory && matchesDifficulty && matchesDuration
        }
    }
    
    var filteredPacks: [(String, Int, String, String)] {
        guard !searchText.isEmpty else { return [] }
        return allPacks.filter { pack in
            let matchesSearch = pack.0.lowercased().contains(searchText.lowercased())
            let matchesDifficulty = selectedDifficulty.isEmpty || selectedDifficulty.contains(pack.3)
            return matchesSearch && matchesDifficulty
        }
    }
    
    var filteredChallenges: [(String, Int, String, String)] {
        guard !searchText.isEmpty else { return [] }
        return allChallenges.filter { challenge in
            let matchesSearch = challenge.0.lowercased().contains(searchText.lowercased())
            let matchesDifficulty = selectedDifficulty.isEmpty || selectedDifficulty.contains(challenge.3)
            return matchesSearch && matchesDifficulty
        }
    }
    
    var hasResults: Bool {
        !filteredUsers.isEmpty || !filteredExercises.isEmpty || !filteredPacks.isEmpty || !filteredChallenges.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search header
                VStack(spacing: 12) {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black.opacity(0.5))
                            TextField("Search library", text: $searchText)
                                .font(.DIN())
                                .fontWeight(.medium)
                                .focused($isSearchFocused)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightGray, lineWidth: 2)
                        )
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Text("Clear")
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundStyle(.lightBlue)
                            }
                        }
                    }
                    
                    // Category filters
                    if !searchText.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                Button(action: {
                                    showFilterSheet = true
                                }) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "slider.horizontal.3")
                                            .font(.system(size: 14))
                                        Text("Filters")
                                    }
                                    .font(.DIN(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor((!selectedDifficulty.isEmpty || selectedDuration != "All") ? .white : .lightBlue)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background((!selectedDifficulty.isEmpty || selectedDuration != "All") ? .customRed : .white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke((!selectedDifficulty.isEmpty || selectedDuration != "All") ? .clear : .lightGray, lineWidth: 2)
                                    )
                                }
                                
                                ForEach(filters, id: \.self) { filter in
                                    Button(action: {
                                        selectedFilter = filter
                                    }) {
                                        Text(filter)
                                            .font(.DIN(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(selectedFilter == filter ? .white : .lightBlue)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            .background(selectedFilter == filter ? .lightBlue : .white)
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(selectedFilter == filter ? .clear : .lightGray, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if searchText.isEmpty {
                            // Recent searches
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Recent Searches")
                                    .font(.DIN(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                                    .padding(.horizontal)
                                
                                ForEach(recentSearches, id: \.self) { search in
                                    Button(action: {
                                        searchText = search
                                    }) {
                                        HStack {
                                            Image(systemName: "clock.arrow.circlepath")
                                                .foregroundStyle(.black.opacity(0.4))
                                            
                                            Text(search)
                                                .font(.DIN(size: 16))
                                                .fontWeight(.medium)
                                                .foregroundStyle(.black.opacity(0.7))
                                            
                                            Spacer()
                                            
                                            Image(systemName: "arrow.up.backward")
                                                .foregroundStyle(.black.opacity(0.3))
                                                .font(.system(size: 14))
                                        }
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.black.opacity(0.1), lineWidth: 2)
                                        )
                                    }
                                    .padding(.horizontal)
                                }
                                
                                if !recentSearches.isEmpty {
                                    Button(action: {
                                        recentSearches.removeAll()
                                    }) {
                                        Text("Clear recent searches")
                                            .font(.DIN())
                                            .fontWeight(.medium)
                                            .foregroundStyle(.customRed)
                                            .padding(.horizontal)
                                            .padding(.top, 4)
                                    }
                                }
                            }
                            .padding(.top)
                        } else if hasResults {
                            // Users section
                            if !filteredUsers.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Users")
                                            .font(.DIN(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Text("(\(filteredUsers.count))")
                                            .font(.DIN(size: 16))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    ForEach(Array(filteredUsers.prefix(2)), id: \.1) { user in
                                        ClickableUserCard(name: user.0, username: user.1, followers: user.2)
                                            .padding(.horizontal)
                                    }
                                    
                                    if filteredUsers.count > 2 {
                                        Button(action: {
                                            showAllUsers = true
                                        }) {
                                            HStack {
                                                Text("View more (\(filteredUsers.count - 2) more)")
                                                    .font(.DIN())
                                                    .fontWeight(.medium)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 14))
                                            }
                                            .foregroundStyle(.lightBlue)
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.lightGray, lineWidth: 2)
                                            )
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            
                            // Exercises section
                            if !filteredExercises.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Exercises")
                                            .font(.DIN(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Text("(\(filteredExercises.count))")
                                            .font(.DIN(size: 16))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    ForEach(Array(filteredExercises.prefix(2)), id: \.0) { exercise in
                                        ClickableExerciseCard(
                                            title: exercise.0,
                                            duration: exercise.1,
                                            difficulty: exercise.2,
                                            category: exercise.3,
                                            isPurchased: true
                                        )
                                        .padding(.horizontal)
                                    }
                                    
                                    if filteredExercises.count > 2 {
                                        Button(action: {
                                            showAllExercises = true
                                        }) {
                                            HStack {
                                                Text("View more (\(filteredExercises.count - 2) more)")
                                                    .font(.DIN())
                                                    .fontWeight(.medium)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 14))
                                            }
                                            .foregroundStyle(.lightBlue)
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.lightGray, lineWidth: 2)
                                            )
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.top)
                            }
                            
                            // Exercise Packs section
                            if !filteredPacks.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Exercise Packs")
                                            .font(.DIN(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Text("(\(filteredPacks.count))")
                                            .font(.DIN(size: 16))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    ForEach(Array(filteredPacks.prefix(2)), id: \.0) { pack in
                                        ClickablePackCard(
                                            title: pack.0,
                                            itemCount: pack.1,
                                            type: pack.2,
                                            difficulty: pack.3
                                        )
                                        .padding(.horizontal)
                                    }
                                    
                                    if filteredPacks.count > 2 {
                                        Button(action: {
                                            showAllPacks = true
                                        }) {
                                            HStack {
                                                Text("View more (\(filteredPacks.count - 2) more)")
                                                    .font(.DIN())
                                                    .fontWeight(.medium)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 14))
                                            }
                                            .foregroundStyle(.lightBlue)
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.lightGray, lineWidth: 2)
                                            )
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.top)
                            }
                            
                            // Challenges section
                            if !filteredChallenges.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Challenges")
                                            .font(.DIN(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Text("(\(filteredChallenges.count))")
                                            .font(.DIN(size: 16))
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.5))
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    ForEach(Array(filteredChallenges.prefix(2)), id: \.0) { challenge in
                                        ClickablePackCard(
                                            title: challenge.0,
                                            itemCount: challenge.1,
                                            type: challenge.2,
                                            difficulty: challenge.3
                                        )
                                        .padding(.horizontal)
                                    }
                                    
                                    if filteredChallenges.count > 2 {
                                        Button(action: {
                                            showAllChallenges = true
                                        }) {
                                            HStack {
                                                Text("View more (\(filteredChallenges.count - 2) more)")
                                                    .font(.DIN())
                                                    .fontWeight(.medium)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .font(.system(size: 14))
                                            }
                                            .foregroundStyle(.lightBlue)
                                            .padding()
                                            .background(.white)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.lightGray, lineWidth: 2)
                                            )
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.top)
                            }
                        } else {
                            // No results
                            VStack(spacing: 16) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 48))
                                    .foregroundStyle(.black.opacity(0.3))
                                    .padding(.top, 40)
                                
                                Text("No results found")
                                    .font(.DIN(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black.opacity(0.7))
                                
                                Text("Try different keywords or filters")
                                    .font(.DIN(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .background(Color.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left").foregroundStyle(
                                                        .black.opacity(0.6))
                                                            Text("Back")
                                                                .font(.DIN())
                                                                .fontWeight(.medium)
                                                                .foregroundStyle(.black.opacity(0.6))
                        }
                        .font(.DIN())
                        .fontWeight(.medium)
                        .foregroundStyle(.lightBlue)
                    }
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheetView(
                    selectedDifficulty: $selectedDifficulty,
                    selectedDuration: $selectedDuration,
                    difficulties: difficulties,
                    durations: durations
                )
            }
            .fullScreenCover(isPresented: $showAllUsers) {
                UsersListView(users: filteredUsers, title: "Users")
            }
            .fullScreenCover(isPresented: $showAllExercises) {
                ExercisesListView(exercises: filteredExercises, title: "Exercises")
            }
            .fullScreenCover(isPresented: $showAllPacks) {
                PacksListView(packs: filteredPacks, title: "Exercise Packs")
            }
            .fullScreenCover(isPresented: $showAllChallenges) {
                PacksListView(packs: filteredChallenges, title: "Challenges")
            }
            .onAppear {
                isSearchFocused = true
            }
        }
    }
}

// MARK: - Library Tab Main View
struct LibraryTab: View {
    @State private var showSearch: Bool = false
    @State private var selectedFilter: String = "All"
    @State private var showAllMyExercises: Bool = false
    @State private var showAllPurchased: Bool = false
    @State private var showAllFavorites: Bool = false
    
    let filters = ["All", "Strength", "Cardio", "Flexibility", "Balance"]
    
    // Full data sets - using slices from MockLibraryData
    let myExercises = Array(MockLibraryData.allExercises.prefix(25))
    let purchasedExercises = Array(MockLibraryData.allExercises.dropFirst(25).prefix(30))
    let favoriteExercises = Array(MockLibraryData.allExercises.dropFirst(55).prefix(20))
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header Section
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text("Library")
                    .font(.DIN(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.7))
                    .padding(.horizontal)
                    .padding(.top, 12)
                
                // Search bar (clickable to open search view)
                Button(action: {
                    showSearch = true
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black.opacity(0.5))
                        Text("Search library")
                            .font(.DIN())
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.4))
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightGray, lineWidth: 2)
                    )
                }
                .padding(.horizontal)
                
                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(filters, id: \.self) { filter in
                            Button(action: {
                                selectedFilter = filter
                            }) {
                                Text(filter)
                                    .font(.DIN())
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedFilter == filter ? .white : .lightBlue)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(selectedFilter == filter ? .lightBlue : .white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedFilter == filter ? .clear : .lightGray, lineWidth: 2)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 12)
            }
            .background(.white)
            .overlay(
                Rectangle()
                    .fill(.lightGray.opacity(0.3))
                    .frame(height: 1)
                    .offset(y: 0),
                alignment: .bottom
            )
            
            // Scrollable Content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 8)
                    
                    // My Exercises Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("My Exercises")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Spacer()
                        
                        Button(action: {
                            showAllMyExercises = true
                        }) {
                            Text("See all")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.lightBlue)
                        }
                    }
                    .padding(.horizontal)
                    
                    ForEach(Array(myExercises.prefix(2)), id: \.0) { exercise in
                        ClickableExerciseCard(
                            title: exercise.0,
                            duration: exercise.1,
                            difficulty: exercise.2,
                            category: exercise.3,
                            isPurchased: true
                        )
                        .padding(.horizontal)
                    }
                }
                
                // Purchased Exercises Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Purchased Exercises")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        Spacer()
                        
                        Button(action: {
                            showAllPurchased = true
                        }) {
                            Text("See all")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.lightBlue)
                        }
                    }
                    .padding(.horizontal)
                    
                    ForEach(Array(purchasedExercises.prefix(2)), id: \.0) { exercise in
                        ClickableExerciseCard(
                            title: exercise.0,
                            duration: exercise.1,
                            difficulty: exercise.2,
                            category: exercise.3,
                            isPurchased: true
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                
                // Favorite Exercises Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        HStack(spacing: 6) {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.customRed)
                                .font(.system(size: 16))
                            Text("Favorite Exercises")
                                .font(.DIN(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showAllFavorites = true
                        }) {
                            Text("See all")
                                .font(.DIN(size: 14))
                                .fontWeight(.medium)
                                .foregroundStyle(.lightBlue)
                        }
                    }
                    .padding(.horizontal)
                    
                    ForEach(Array(favoriteExercises.prefix(2)), id: \.0) { exercise in
                        ClickableExerciseCard(
                            title: exercise.0,
                            duration: exercise.1,
                            difficulty: exercise.2,
                            category: exercise.3,
                            isPurchased: true
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                
                Spacer()
                    .frame(height: 20)
                }
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showSearch) {
            SearchView()
        }
        .fullScreenCover(isPresented: $showAllMyExercises) {
            ExercisesListView(exercises: myExercises, title: "My Exercises")
        }
        .fullScreenCover(isPresented: $showAllPurchased) {
            ExercisesListView(exercises: purchasedExercises, title: "Purchased Exercises")
        }
        .fullScreenCover(isPresented: $showAllFavorites) {
            ExercisesListView(exercises: favoriteExercises, title: "Favorite Exercises")
        }
    }
}

// MARK: - Filter Sheet View
struct FilterSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedDifficulty: Set<String>
    @Binding var selectedDuration: String
    
    let difficulties: [String]
    let durations: [String]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Difficulty Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Difficulty")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        ForEach(difficulties, id: \.self) { difficulty in
                            Button(action: {
                                if selectedDifficulty.contains(difficulty) {
                                    selectedDifficulty.remove(difficulty)
                                } else {
                                    selectedDifficulty.insert(difficulty)
                                }
                            }) {
                                HStack {
                                    Text(difficulty)
                                        .font(.DIN(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Spacer()
                                    
                                    if selectedDifficulty.contains(difficulty) {
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
                    
                    // Duration Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Duration")
                            .font(.DIN(size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        ForEach(durations, id: \.self) { duration in
                            Button(action: {
                                selectedDuration = duration
                            }) {
                                HStack {
                                    Text(duration)
                                        .font(.DIN(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Spacer()
                                    
                                    if selectedDuration == duration {
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
                    
                    // Reset button
                    PrimitiveButton(content: "Reset filters", type: .tertiary) {
                        selectedDifficulty = []
                        selectedDuration = "All"
                    }
                    .padding(.top)
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.DIN(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.lightBlue)
                }
            }
        }
    }
}

#Preview("Library Tab") {
    LibraryTab()
}

#Preview("Search View") {
    SearchView()
}
