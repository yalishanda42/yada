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
                .map { _ in .hideAuthenticationScreen }
                .catch { (error) -> AnyPublisher<AppAction, Never> in
                    return Just(.presentAlert(message: error.localizedErrorMessage))
                        .eraseToAnyPublisher()
                }.eraseToAnyPublisher()
            
        case .signUp(email: let email, password: let password, passwordRepeated: let password2):
            guard password == password2 else {
                return Just(.presentAlert(message: AuthenticationError.passwordsDoNotMatch.localizedErrorMessage))
                    .eraseToAnyPublisher()
            }
            return environment
                .authenticationService
                .signUpWithEmail(email: email, password: password)
                .map { _ in .hideAuthenticationScreen }
                .catch { (error) -> AnyPublisher<AppAction, Never> in
                    return Just(.presentAlert(message: error.localizedErrorMessage))
                        .eraseToAnyPublisher()
                }.eraseToAnyPublisher()
            
        case .presentAlert(message: let message):
            state.alertTextMessage = message
            state.alertIsPresented = true
            
        case .dismissAlert:
            state.alertIsPresented = false
            state.alertTextMessage = ""
            
        case .presentAuthenticationScreen:
            state.authScreenIsPresented = true
            
        case .hideAuthenticationScreen:
            state.authScreenIsPresented = false
            
        case .selectTab(let tab):
            state.selectedTab = tab
            
        case .tapSettings:
            state.settingsAreShown = true
            
        case .popBackSettings:
            state.settingsAreShown = false
        }
        
        return Empty().eraseToAnyPublisher()
    }
}

fileprivate extension AuthenticationError {
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

