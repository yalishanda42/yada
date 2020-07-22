//
//  RootViewModel.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Foundation
import Combine

class RootViewModel: ObservableObject {
    @Published var authenticationIsPresented = true
    @Published var simpleAlertIsPresented = false
    @Published var simpleAlertText = ""
    let authenticationViewModel = AuthenticationViewModel()
    let mainViewModel = MainViewModel()

    private var disposeBag: Set<AnyCancellable> = []
    private let authenticationService: AuthenticationService

    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
        declareSubscriptions()
    }
    
    private func declareSubscriptions() {
        let signUpSuccess = authenticationViewModel.signUpTapped.flatMap(signUpPublisher)
        
        Publishers.Merge(signUpSuccess, authenticationViewModel.logInTapped)
            .map { _ in }
            .flatMap(signInPublisher)
            .sink { _ in }
            .store(in: &disposeBag)
        
        authenticationService.isAuthenticated
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] isAuthenticated in
                if isAuthenticated {
                    self?.authenticationIsPresented = false
                }
            }.store(in: &disposeBag)
    }
    
    private func signInPublisher() -> AnyPublisher<Void, Never> {
        let email = self.authenticationViewModel.loginFormViewModel.emailText
        let passw = self.authenticationViewModel.loginFormViewModel.passwordText
        return self.authenticationService
            .logInWithEmail(email: email, password: passw)
            .catch { [weak self] error -> Empty<Void, Never> in
                self?.simpleAlertText = error.localizedErrorMessage
                self?.simpleAlertIsPresented = true
                return Empty(completeImmediately: true)
            }.eraseToAnyPublisher()
    }
    
    private func signUpPublisher() -> AnyPublisher<Void, Never> {
        let email = self.authenticationViewModel.loginFormViewModel.emailText
        let passw = self.authenticationViewModel.loginFormViewModel.passwordText
        return self.authenticationService
            .signUpWithEmail(email: email, password: passw)
            .catch { [weak self] error -> Empty<Void, Never> in
                self?.simpleAlertText = error.localizedErrorMessage
                self?.simpleAlertIsPresented = true
                return Empty(completeImmediately: true)
            }.eraseToAnyPublisher()
    }
}
