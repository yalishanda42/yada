//
//  AuthenticationViewModel.swift
//  Date Me
//
//  Created by Alexander Ignatov on 21.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var mode: Mode = .signIn {
        willSet {
            loginFormViewModel.mode = mode
        }
    }
    
    lazy var loginFormViewModel = LoginFormViewModel(mode: mode)
    
    lazy var signInFinished = loginFormViewModel.buttonTap.eraseToAnyPublisher()
}

extension AuthenticationViewModel {
    enum Mode: Int {
        case signIn = 0
        case signUp = 1
        
        var buttonText: String {
            switch self {
            case .signIn:
                return "Login"
            case .signUp:
                return "Sign up"
            }
        }
        
        var buttonIndex: Int {
            get {
                rawValue
            } set {
                self = Mode(rawValue: newValue)!
            }
        }
    }
}
