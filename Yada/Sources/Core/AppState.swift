//
//  AppState.swift
//  Yada
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

public struct AppState: Equatable {
    
    // MARK: - Alert
    public var alertIsPresented = false
    public var alertTextMessage = ""
    
    // MARK: - Authentication
    public var authScreenIsPresented = false
    
    // MARK: - Tabs
    public var selectedTab: Tab = .default
    
    // MARK: - Settings
    public var settingsAreShown = false
    
    // MARK: - User
    public var user: UserState = .guest(.init())
}

// MARK: - Nested Types

public extension AppState {
    // MARK: - Tab
    enum Tab: Int, CaseIterable, Equatable {
        case messages
        case match
        case account
        
        public var index: Int { rawValue }
        
        public static var `default`: Self { .messages }
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
        public var email = ""
        public var fullName = ""
    }
}
