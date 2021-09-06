//
//  MockServiceDependencies.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Foundation
@testable import DateMeCore

class MockServiceDependencies: ServiceDependencies {
    let authenticationService: AuthenticationService
    
    init(authenticationService: MockAuthenticationService = .init()) {
        self.authenticationService = authenticationService
    }
}
