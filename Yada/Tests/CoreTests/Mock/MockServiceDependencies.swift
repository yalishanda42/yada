//
//  MockServiceDependencies.swift
//  Yada
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Foundation
@testable import Core

class MockServiceDependencies: ServiceDependencies {
    let authenticationService: AuthenticationService
    
    init(authenticationService: MockAuthenticationService = .init()) {
        self.authenticationService = authenticationService
    }
}
