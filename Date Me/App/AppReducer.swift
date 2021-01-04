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
        environment: ServiceDepdendencies
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
