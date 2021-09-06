//
//  AppState.swift
//  Date Me
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

struct AppState: Equatable {
    
    // MARK: - Alert
    var alertIsPresented = false
    var alertTextMessage = ""
    
    // MARK: - Authentication
    var authScreenIsPresented = false
    
    // MARK: - Tabs
    var selectedTab: Tab = .default
    
    // MARK: - Settings
    var settingsAreShown = false
    
    // MARK: - User
    var user: UserState = .guest(.init())
}

// MARK: - Nested Types

extension AppState {
    // MARK: - Tab
    enum Tab: Int, CaseIterable, Equatable {
        case messages
        case match
        case account
        
        var index: Int { rawValue }
        
        static var `default`: Self { .messages }
    }
    
    // MARK: - User State
    enum UserState: Equatable {
        case guest(GuestUser)
        case authenticated(AuthenticatedUser)
    }
    
    // MARK: - Guest User
    struct GuestUser: Equatable {
    }
    
    // MARK: - Authenticated User
    struct AuthenticatedUser: Equatable {
        var email = ""
        var fullName = ""
    }
}
