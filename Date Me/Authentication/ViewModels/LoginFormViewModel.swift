//
//  LoginFormViewModel.swift
//  Date Me
//
//  Created by Alexander Ignatov on 21.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

class LoginFormViewModel: ObservableObject {
    @Published var mode: AuthenticationViewModel.Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var passwordRepeatedText = ""
    
    let buttonTap = PassthroughSubject<Void, Never>()
    
    init(mode: AuthenticationViewModel.Mode) {
        self.mode = mode
    }
}
