//
//  AppReducer.swift
//  Yada
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import ComposableArchitecture

public enum AppReducer {
    public static let reduce = Reducer<AppState, AppAction, ServiceDependencies> {
        state, action, environment in
        
        switch action {
        
        case .logIn(email: let email, password: let password):
            return environment
                .authenticationService
                .logInWithEmail(email: email, password: password)
                .catchToEffect(AppAction.authentication)
            
        case .signUp(email: let email, password: let password, passwordRepeated: let password2):
            guard password == password2 else {
                return .init(value: .showAlert(message: AuthenticationError.passwordsDoNotMatch.localizedErrorMessage))
            }
            
            return environment
                .authenticationService
                .signUpWithEmail(email: email, password: password)
                .catchToEffect(AppAction.authentication)
            
        case .showAlert(message: let message):
            state.alertTextMessage = message
            state.alertIsPresented = true
            
        case .hideAlert:
            state.alertIsPresented = false
            state.alertTextMessage = ""
            
        case .showAuthentication:
            state.authScreenIsPresented = true
            
        case .hideAuthentication:
            state.authScreenIsPresented = false
            
        case .selectTab(let tab):
            state.selectedTab = tab
            
        case .showSettings:
            state.settingsAreShown = true
            
        case .hideSettings:
            state.settingsAreShown = false
            
        case .authentication(.success(let userInfo)):
            switch state.user {
            case .guest(let oldData):
                // migrate guest to auth
                state.user = .authenticated(.init(with: userInfo, from: oldData))
            case .authenticated(_):
                state.user = .authenticated(.init(with: userInfo))
            }
            return .init(value: .hideAuthentication)
        
        case .authentication(.failure(let error)):
            return .init(value: .showAlert(message: error.localizedErrorMessage))
        }
        
        return .none
    }
}
// MARK: - Error Message

extension AuthenticationError {
    var localizedErrorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "auth.error.email_already_in_use".localized
        case .userDisabled:
            return "auth.error.disabled_account".localized
        case .invalidEmail:
            return "auth.error.invalid_email".localized
        case .networkError:
            return "auth.error.network_error".localized
        case .weakPassword:
            return "auth.error.weak_password".localized
        case .wrongPassword:
            return "auth.error.wrong_password".localized
        case .passwordsDoNotMatch:
            return "auth.error.passwords_not_matching".localized
        case .unknown:
            return "auth.error.unknown".localized
        }
    }
}

extension AppState.AuthenticatedUser {
    init(with info: AppAction.AuthenticationInfo, from oldData: AppState.GuestUser) {
        self.email = info.email
        self.fullName = info.fullName
    }
    
    init(with info: AppAction.AuthenticationInfo) {
        self.email = info.email
        self.fullName = info.fullName
    }
}
