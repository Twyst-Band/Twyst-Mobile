//
//  CategorySkillTreeView.swift
//  Twyst
//
//  Created by Karo on 05.10.2025.
//

import SwiftUI

struct CategorySkillTreeView: View {
    @Environment(\.dismiss) var dismiss
    let category: FitnessCategory
    @State private var selectedSkill: SkillNode? = nil
    
    var skillTree: [SkillNode] {
        switch category.id {
        case 1: return CalisthenicsTree.nodes
        case 2: return YogaTree.nodes
        case 3: return StrengthTree.nodes
        case 4: return CardioTree.nodes
        default: return CalisthenicsTree.nodes
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16))
                                .foregroundStyle(Color(white: 0.4))
                            
                            Text("Back")
                                .font(.DIN())
                                .fontWeight(.medium)
                                .foregroundStyle(Color(white: 0.4))
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text(category.name)
                            .font(.DIN(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        
                        Text("\(category.completedExercises)/\(category.totalExercises) Complete")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(Color(white: 0.5))
                    }
                    
                    Spacer()
                    
                    // Spacer for balance
                    Text("")
                        .frame(width: 60)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                
                // Skill Tree
                ScrollView([.horizontal, .vertical], showsIndicators: true) {
                    SkillTreeRenderer(
                        nodes: skillTree,
                        category: category,
                        onNodeTap: { node in
                            if node.isUnlocked {
                                selectedSkill = node
                            }
                        }
                    )
                    .padding(.vertical, 40)
                    .padding(.horizontal, 20)
                }
            }
        }
        .fullScreenCover(item: $selectedSkill) { skill in
            SkillDetailView(skill: skill, categoryColor: category.color, categoryName: category.name)
        }
    }
}

// MARK: - Skill Tree Renderer
struct SkillTreeRenderer: View {
    let nodes: [SkillNode]
    let category: FitnessCategory
    let onNodeTap: (SkillNode) -> Void
    
    // Calculate max level for proper sizing
    var maxLevel: Int {
        nodes.map { $0.level }.max() ?? 0
    }
    
    // Calculate required width based on max horizontal position
    var minHorizontalPosition: Int {
        nodes.map { $0.horizontalPosition }.min() ?? 0
    }
    
    var maxHorizontalPosition: Int {
        nodes.map { $0.horizontalPosition }.max() ?? 0
    }
    
    var body: some View {
        let horizontalSpacing: CGFloat = 130
        let nodeWidth: CGFloat = 120
        let totalHorizontalNodes = CGFloat(maxHorizontalPosition - minHorizontalPosition + 1)
        let contentWidth = max(totalHorizontalNodes * horizontalSpacing + 200, UIScreen.main.bounds.width)
        let height = CGFloat((maxLevel + 1) * 240 + 140)
        
        ZStack {
            // Draw all connections first
            ForEach(nodes) { node in
                ForEach(node.prerequisiteIds, id: \.self) { prereqId in
                    if let prereqNode = nodes.first(where: { $0.id == prereqId }) {
                        ConnectionPath(
                            from: calculatePosition(for: prereqNode, totalWidth: contentWidth, totalHeight: height),
                            to: calculatePosition(for: node, totalWidth: contentWidth, totalHeight: height),
                            isUnlocked: node.isUnlocked,
                            color: category.color
                        )
                    }
                }
            }
            
            // Draw nodes on top
            ForEach(nodes) { node in
                SkillNodeView(
                    node: node,
                    color: category.color,
                    onTap: { onNodeTap(node) }
                )
                .position(calculatePosition(for: node, totalWidth: contentWidth, totalHeight: height))
            }
        }
        .frame(width: contentWidth, height: height)
    }
    
    func calculatePosition(for node: SkillNode, totalWidth: CGFloat, totalHeight: CGFloat) -> CGPoint {
        // Calculate vertical position (bottom to top, starting from bottom)
        let levelHeight: CGFloat = 240
        let yPos = totalHeight - CGFloat(node.level) * levelHeight - 120
        
        // Calculate horizontal position based on branch
        let horizontalSpacing: CGFloat = 130
        let centerX = totalWidth / 2
        let xOffset = CGFloat(node.horizontalPosition) * horizontalSpacing
        let xPos = centerX + xOffset
        
        return CGPoint(x: xPos, y: yPos)
    }
}

// MARK: - Connection Path
struct ConnectionPath: View {
    let from: CGPoint
    let to: CGPoint
    let isUnlocked: Bool
    let color: Color
    
    var body: some View {
        Path { path in
            path.move(to: from)
            
            // Create smooth bezier curve with better control points
            let verticalDistance = from.y - to.y
            let horizontalDistance = abs(to.x - from.x)
            
            // Adjust curve intensity based on horizontal distance
            let curveFactor: CGFloat = horizontalDistance > 50 ? 0.5 : 0.4
            
            let controlPoint1 = CGPoint(
                x: from.x + (to.x - from.x) * 0.2,
                y: from.y - verticalDistance * curveFactor
            )
            let controlPoint2 = CGPoint(
                x: to.x - (to.x - from.x) * 0.2,
                y: to.y + verticalDistance * curveFactor
            )
            
            path.addCurve(
                to: to,
                control1: controlPoint1,
                control2: controlPoint2
            )
        }
        .stroke(
            isUnlocked ? color : Color(white: 0.85),
            style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
        )
    }
}

// MARK: - Skill Node View
struct SkillNodeView: View {
    let node: SkillNode
    let color: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                // Node Circle
                ZStack {
                    // Main circle
                    Circle()
                        .fill(
                            node.isUnlocked ?
                            LinearGradient(
                                gradient: Gradient(colors: [color, color]),
                                startPoint: .top,
                                endPoint: .bottom
                            ) :
                            LinearGradient(
                                gradient: Gradient(colors: [.gray, .gray]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 68, height: 68)
                        .shadow(
                            color: node.isUnlocked ? color.opacity(0.3) : Color.black.opacity(0.1),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                    
                    // Icon or Status
                    if node.isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.white)
                    } else if node.isUnlocked {
                        Image(systemName: "dumbbell.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(.white)
                    } else {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                    }
                }
                
                // Label (directly below, no gap)
                VStack(spacing: 4) {
                    Text(node.name)
                        .font(.DIN(size: 14))
                        .fontWeight(.bold)
                        .foregroundStyle(node.isUnlocked ? .black : Color(white: 0.6))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 9))
                            .foregroundStyle(node.isUnlocked ? .goldYellow : .gray)
                        
                        Text("\(node.xp) XP")
                            .font(.DIN(size: 12))
                            .fontWeight(.medium)
                            .foregroundStyle(node.isUnlocked ? .goldYellow : .gray)
                    }
                }
                .frame(width: 100)
                .padding(.vertical, 8)
                .padding(.horizontal, 6)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightGray, lineWidth: 2)
                )
                .offset(y: -4)
            }
        }
        .disabled(!node.isUnlocked)
    }
}

// MARK: - Skill Detail View
struct SkillDetailView: View {
    @Environment(\.dismiss) var dismiss
    let skill: SkillNode
    let categoryColor: Color
    let categoryName: String
    @State private var showExerciseDetail: Bool = false
    
    // Cached random duration
    let estimatedDuration: String
    
    init(skill: SkillNode, categoryColor: Color, categoryName: String) {
        self.skill = skill
        self.categoryColor = categoryColor
        self.categoryName = categoryName
        
        // Initialize random duration once based on difficulty
        switch skill.difficulty {
        case "Beginner":
            self.estimatedDuration = "\(Int.random(in: 5...15)) min"
        case "Intermediate":
            self.estimatedDuration = "\(Int.random(in: 15...30)) min"
        case "Advanced":
            self.estimatedDuration = "\(Int.random(in: 25...45)) min"
        case "Expert":
            self.estimatedDuration = "\(Int.random(in: 40...60)) min"
        default:
            self.estimatedDuration = "20 min"
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Large icon
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [categoryColor, categoryColor]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "dumbbell.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 40)
                    
                    VStack(spacing: 8) {
                        Text(skill.name)
                            .font(.DIN(size: 32))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        
                        HStack(spacing: 12) {
                            Text(skill.difficulty)
                                .font(.DIN(size: 14))
                                .fontWeight(.bold)
                                .foregroundStyle(categoryColor)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(categoryColor, lineWidth: 2)
                                )
                            
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.goldYellow)
                                
                                Text("\(skill.xp) XP")
                                    .font(.DIN(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.goldYellow)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.goldYellow, lineWidth: 2)
                            )
                        }
                    }
                    
                    Text(skill.description)
                        .font(.DIN())
                        .fontWeight(.medium)
                        .foregroundStyle(Color(white: 0.4))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    PrimitiveButton(content: "Start Exercise", type: .primary) {
                        showExerciseDetail = true
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .background(Color.white)
            .navigationTitle("Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showExerciseDetail) {
            ExerciseDetailView(
                title: skill.name,
                duration: estimatedDuration,
                difficulty: skill.difficulty,
                category: categoryName
            )
        }
    }
}

// MARK: - Skill Node Model
struct SkillNode: Identifiable {
    let id: Int
    let name: String
    let level: Int
    let horizontalPosition: Int  // -2, -1, 0, 1, 2 etc for left/right positioning
    let prerequisiteIds: [Int]
    let xp: Int
    let difficulty: String
    let description: String
    let isUnlocked: Bool
    let isCompleted: Bool
}

// MARK: - Calisthenics Skill Tree
struct CalisthenicsTree {
    static let nodes: [SkillNode] = [
        // Level 0 - Foundation
        SkillNode(id: 1, name: "Basic Push-up", level: 0, horizontalPosition: 0, prerequisiteIds: [], xp: 10, difficulty: "Beginner", description: "Master the fundamental push-up with proper form", isUnlocked: true, isCompleted: true),
        
        // Level 1 - Branches from basic
        SkillNode(id: 2, name: "Wide Push-up", level: 1, horizontalPosition: -1, prerequisiteIds: [1], xp: 15, difficulty: "Beginner", description: "Widen your stance to target chest muscles", isUnlocked: true, isCompleted: true),
        SkillNode(id: 3, name: "Diamond Push-up", level: 1, horizontalPosition: 1, prerequisiteIds: [1], xp: 15, difficulty: "Beginner", description: "Focus on triceps with close-hand positioning", isUnlocked: true, isCompleted: false),
        
        // Level 2 - Multiple paths converge
        SkillNode(id: 4, name: "Archer Push-up", level: 2, horizontalPosition: -1, prerequisiteIds: [2], xp: 20, difficulty: "Intermediate", description: "Shift weight to one arm for asymmetric strength", isUnlocked: true, isCompleted: false),
        SkillNode(id: 5, name: "Pike Push-up", level: 2, horizontalPosition: 0, prerequisiteIds: [3], xp: 20, difficulty: "Intermediate", description: "Elevate hips to target shoulders", isUnlocked: true, isCompleted: false),
        SkillNode(id: 6, name: "Decline Push-up", level: 2, horizontalPosition: 1, prerequisiteIds: [2, 3], xp: 18, difficulty: "Intermediate", description: "Elevate feet for increased difficulty", isUnlocked: true, isCompleted: false),
        
        // Level 3 - Advanced convergence
        SkillNode(id: 7, name: "One-Arm Push-up", level: 3, horizontalPosition: -1, prerequisiteIds: [4], xp: 35, difficulty: "Advanced", description: "The ultimate upper body control exercise", isUnlocked: false, isCompleted: false),
        SkillNode(id: 8, name: "Handstand Push-up", level: 3, horizontalPosition: 0, prerequisiteIds: [5, 6], xp: 40, difficulty: "Advanced", description: "Invert yourself for maximum shoulder strength", isUnlocked: false, isCompleted: false),
        SkillNode(id: 9, name: "Explosive Push-up", level: 3, horizontalPosition: 1, prerequisiteIds: [6], xp: 30, difficulty: "Advanced", description: "Build explosive power with plyometric movements", isUnlocked: false, isCompleted: false),
        
        // Level 4 - Master level
        SkillNode(id: 10, name: "Planche Push-up", level: 4, horizontalPosition: -1, prerequisiteIds: [7, 8], xp: 50, difficulty: "Expert", description: "The pinnacle of horizontal pushing strength", isUnlocked: false, isCompleted: false),
        SkillNode(id: 11, name: "Superman Push-up", level: 4, horizontalPosition: 1, prerequisiteIds: [9], xp: 45, difficulty: "Expert", description: "Launch yourself into the air with explosive power", isUnlocked: false, isCompleted: false),
    ]
}

// MARK: - Yoga Skill Tree
struct YogaTree {
    static let nodes: [SkillNode] = [
        // Foundation
        SkillNode(id: 1, name: "Mountain Pose", level: 0, horizontalPosition: 0, prerequisiteIds: [], xp: 8, difficulty: "Beginner", description: "The foundation of all standing poses", isUnlocked: true, isCompleted: true),
        
        // Level 1
        SkillNode(id: 2, name: "Warrior I", level: 1, horizontalPosition: -1, prerequisiteIds: [1], xp: 12, difficulty: "Beginner", description: "Build strength and stability", isUnlocked: true, isCompleted: true),
        SkillNode(id: 3, name: "Tree Pose", level: 1, horizontalPosition: 1, prerequisiteIds: [1], xp: 12, difficulty: "Beginner", description: "Develop balance and focus", isUnlocked: true, isCompleted: false),
        
        // Level 2
        SkillNode(id: 4, name: "Warrior II", level: 2, horizontalPosition: -2, prerequisiteIds: [2], xp: 15, difficulty: "Intermediate", description: "Open hips and strengthen legs", isUnlocked: true, isCompleted: false),
        SkillNode(id: 5, name: "Triangle Pose", level: 2, horizontalPosition: 0, prerequisiteIds: [2, 3], xp: 18, difficulty: "Intermediate", description: "Stretch and strengthen the entire body", isUnlocked: true, isCompleted: false),
        SkillNode(id: 6, name: "Eagle Pose", level: 2, horizontalPosition: 2, prerequisiteIds: [3], xp: 18, difficulty: "Intermediate", description: "Advanced balance and hip flexibility", isUnlocked: false, isCompleted: false),
        
        // Level 3
        SkillNode(id: 7, name: "Half Moon", level: 3, horizontalPosition: -1, prerequisiteIds: [4, 5], xp: 25, difficulty: "Advanced", description: "Balance on one leg with full extension", isUnlocked: false, isCompleted: false),
        SkillNode(id: 8, name: "Dancer Pose", level: 3, horizontalPosition: 1, prerequisiteIds: [5, 6], xp: 28, difficulty: "Advanced", description: "Graceful balance and deep backbend", isUnlocked: false, isCompleted: false),
        
        // Level 4
        SkillNode(id: 9, name: "King Dancer", level: 4, horizontalPosition: 0, prerequisiteIds: [7, 8], xp: 40, difficulty: "Expert", description: "The ultimate expression of balance and flexibility", isUnlocked: false, isCompleted: false),
    ]
}

// MARK: - Strength Training Tree
struct StrengthTree {
    static let nodes: [SkillNode] = [
        // Foundation
        SkillNode(id: 1, name: "Bodyweight Squat", level: 0, horizontalPosition: 0, prerequisiteIds: [], xp: 10, difficulty: "Beginner", description: "Master the fundamental squat pattern", isUnlocked: true, isCompleted: true),
        
        // Level 1
        SkillNode(id: 2, name: "Goblet Squat", level: 1, horizontalPosition: -1, prerequisiteIds: [1], xp: 15, difficulty: "Beginner", description: "Add weight while maintaining form", isUnlocked: true, isCompleted: false),
        SkillNode(id: 3, name: "Bulgarian Split Squat", level: 1, horizontalPosition: 1, prerequisiteIds: [1], xp: 15, difficulty: "Beginner", description: "Unilateral leg strength", isUnlocked: true, isCompleted: false),
        
        // Level 2
        SkillNode(id: 4, name: "Front Squat", level: 2, horizontalPosition: -1, prerequisiteIds: [2], xp: 22, difficulty: "Intermediate", description: "Build quad and core strength", isUnlocked: false, isCompleted: false),
        SkillNode(id: 5, name: "Back Squat", level: 2, horizontalPosition: 0, prerequisiteIds: [2], xp: 22, difficulty: "Intermediate", description: "The king of leg exercises", isUnlocked: false, isCompleted: false),
        SkillNode(id: 6, name: "Pistol Squat", level: 2, horizontalPosition: 1, prerequisiteIds: [3], xp: 25, difficulty: "Intermediate", description: "Single-leg squat mastery", isUnlocked: false, isCompleted: false),
        
        // Level 3
        SkillNode(id: 7, name: "Overhead Squat", level: 3, horizontalPosition: -1, prerequisiteIds: [4, 5], xp: 30, difficulty: "Advanced", description: "Full body coordination and mobility", isUnlocked: false, isCompleted: false),
        SkillNode(id: 8, name: "Shrimp Squat", level: 3, horizontalPosition: 1, prerequisiteIds: [6], xp: 30, difficulty: "Advanced", description: "Advanced single-leg strength", isUnlocked: false, isCompleted: false),
        
        // Level 4
        SkillNode(id: 9, name: "Dragon Pistol", level: 4, horizontalPosition: 0, prerequisiteIds: [7, 8], xp: 45, difficulty: "Expert", description: "The ultimate leg strength challenge", isUnlocked: false, isCompleted: false),
    ]
}

// MARK: - Cardio & HIIT Tree
struct CardioTree {
    static let nodes: [SkillNode] = [
        // Foundation
        SkillNode(id: 1, name: "Jumping Jacks", level: 0, horizontalPosition: 0, prerequisiteIds: [], xp: 8, difficulty: "Beginner", description: "Basic cardio conditioning", isUnlocked: true, isCompleted: true),
        
        // Level 1
        SkillNode(id: 2, name: "High Knees", level: 1, horizontalPosition: -1, prerequisiteIds: [1], xp: 12, difficulty: "Beginner", description: "Explosive leg drive", isUnlocked: true, isCompleted: false),
        SkillNode(id: 3, name: "Mountain Climbers", level: 1, horizontalPosition: 1, prerequisiteIds: [1], xp: 12, difficulty: "Beginner", description: "Core and cardio combo", isUnlocked: true, isCompleted: false),
        
        // Level 2
        SkillNode(id: 4, name: "Burpees", level: 2, horizontalPosition: 0, prerequisiteIds: [2, 3], xp: 20, difficulty: "Intermediate", description: "Full body explosive movement", isUnlocked: false, isCompleted: false),
        SkillNode(id: 5, name: "Box Jumps", level: 2, horizontalPosition: -2, prerequisiteIds: [2], xp: 18, difficulty: "Intermediate", description: "Develop explosive power", isUnlocked: false, isCompleted: false),
        SkillNode(id: 6, name: "Sprint Intervals", level: 2, horizontalPosition: 2, prerequisiteIds: [3], xp: 18, difficulty: "Intermediate", description: "Maximum speed training", isUnlocked: false, isCompleted: false),
        
        // Level 3
        SkillNode(id: 7, name: "Tabata Protocol", level: 3, horizontalPosition: 0, prerequisiteIds: [4, 5, 6], xp: 35, difficulty: "Advanced", description: "20 seconds max effort, 10 seconds rest", isUnlocked: false, isCompleted: false),
    ]
}

#Preview {
    CategorySkillTreeView(category: FitnessCategory(
        id: 1,
        name: "Calisthenics",
        icon: "figure.mixed.cardio",
        color: .blue,
        totalExercises: 24,
        completedExercises: 12,
        isLocked: false
    ))
}

