//
//  Enums.swift
//  bewavoca-iOS
//
//  Created by kimtaein on 1/9/25.
//

// MARK: AppStatusView 
enum AppDestination: Hashable {
    case loading
    case main
    case onboarding
    case stage
    case setting
    case characterSelect
    case oxGame
    case multipleChoiceGame
    case matchingGame
    case resultGame
    case reward
}

// MARK: Game Stage
enum Stage: CaseIterable, CustomStringConvertible {
    case garden, plateau, village, meadow, ridge
    
    var index: Int {
        switch self {
        case .garden: return 1
        case .plateau: return 2
        case .village: return 3
        case .meadow: return 4
        case .ridge: return 5
        }
    }
    
    var description: String {
        switch self {
        case .garden: return "garden"
        case .plateau: return "plateau"
        case .village: return "village"
        case .meadow: return "meadow"
        case .ridge: return "ridge"
        }
    }
}

// MARK: Game Type
enum GameType: CaseIterable, CustomStringConvertible {
    case ox, choice, match
    
    var level: Int {
        switch self {
        case .ox: return 1
        case .choice: return 2
        case .match: return 3
        }
    }
    
    var description: String {
        switch self {
        case .ox: return "ox"
        case .choice: return "choice"
        case .match: return "match"
        }
    }
}

// MARK: Sound Resource
enum BackgroundMusic: String, Equatable {
    case story = "background_story"
    case main = "background_main"
    case quiz = "background_quiz"
}

// MARK: Haptic Resource
enum HapticType {
    case impact(ImpactType)
    case selection
    case tap
    case none
}

enum ImpactType {
    case light, medium, heavy, soft, rigid
}


