//
//  AppReducer.swift
//  Date Me
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Foundation
import Combine

enum AppReducer {
    static func reduce(
        state: inout AppState,
        action: AppAction,
        environment: ServiceDependencies
    ) -> AnyPublisher<AppAction, Never> {
        switch action {
        
        case .logIn(email: let email, password: let password):
            return environment
                .authenticationService
                .logInWithEmail(email: email, password: password)
                .map { .authenticationSuccess($0) }
                .catch { (error) -> AnyPublisher<AppAction, Never> in
                    return Just(.showAlert(message: error.localizedErrorMessage))
                        .eraseToAnyPublisher()
                }.eraseToAnyPublisher()
            
        case .signUp(email: let email, password: let password, passwordRepeated: let password2):
            guard password == password2 else {
                return Just(.showAlert(message: AuthenticationError.passwordsDoNotMatch.localizedErrorMessage))
                    .eraseToAnyPublisher()
            }
            return environment
                .authenticationService
                .signUpWithEmail(email: email, password: password)
                .map { .authenticationSuccess($0) }
                .catch { (error) -> AnyPublisher<AppAction, Never> in
                    return Just(.showAlert(message: error.localizedErrorMessage))
                        .eraseToAnyPublisher()
                }.eraseToAnyPublisher()
            
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
            
        case .authenticationSuccess(let userInfo):
            switch state.user {
            case .guest(let oldData):
                // migrate guest to auth
                state.user = .authenticated(.init(with: userInfo, from: oldData))
            case .authenticated(_):
                state.user = .authenticated(.init(with: userInfo))
            }
            return Just(.hideAuthentication).eraseToAnyPublisher()
        }
        
        return Empty().eraseToAnyPublisher()
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
