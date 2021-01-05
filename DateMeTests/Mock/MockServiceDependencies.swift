//
//  MockServiceDependencies.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Foundation
@testable import Date_Me

class MockServiceDependencies: ServiceDependencies {
    lazy var authenticationService: AuthenticationService = MockAuthenticationService()
}
