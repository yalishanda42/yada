//
//  AppState.swift
//  Date Me
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

struct AppState {
    
    // MARK: - Alert
    var alertIsPresented = false
    var alertTextMessage = ""
    
    // MARK: - Authentication
    var authScreenIsPresented = false
    
    // MARK: - Tabs
    var selectedTab: Tab = .default
    
}

extension AppState {
    enum Tab: Int, CaseIterable, Equatable {
        case messages
        case match
        case account
        
        var index: Int { rawValue }
        
        static var `default`: Self { .messages }
    }
}
