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
        didSet {
            loginFormViewModel.mode = mode
        }
    }
    
    lazy var loginFormViewModel = LoginFormViewModel(mode: mode)
    
    lazy var logInTapped = loginFormViewModel.buttonTap
        .filter { [unowned self] _ in self.mode == .signIn }
        .eraseToAnyPublisher()
    
    lazy var signUpTapped = loginFormViewModel.buttonTap
        .filter { [unowned self] _ in self.mode == .signUp }
        .eraseToAnyPublisher()
}

extension AuthenticationViewModel {
    enum Mode: Int, CaseIterable {
        case signIn = 0
        case signUp = 1
        
        var buttonIndex: Int {
            get {
                rawValue
            } set {
                self = Mode(rawValue: newValue)!
            }
        }
        
        var buttonText: String {
            switch self {
            case .signIn:
                return "Login".localized
            case .signUp:
                return "Sign up".localized
            }
        }
        
        var segmentButtonTitle: String {
            switch self {
            case .signIn:
                return "Existing".localized
            case .signUp:
                return "New".localized
            }
        }
    }
}
