//
//  AppAction.swift
//  Date Me
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Foundation

public enum AppAction: Equatable {
    case logIn(email: String, password: String)
    case signUp(email: String, password: String, passwordRepeated: String)
    case authentication(Result<AuthenticationInfo, AuthenticationError>)
    
    case showAlert(message: String)
    case hideAlert
    
    case showAuthentication
    case hideAuthentication
    
    case selectTab(AppState.Tab)
    
    case showSettings
    case hideSettings
}

public extension AppAction {
    struct AuthenticationInfo: Equatable {
        public var id: String = ""
        public var email: String = ""
        public var fullName: String = ""
    }
}
