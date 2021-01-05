//
//  MockedService.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Foundation

protocol MockService {}

extension MockService {
    func when<T>(_ keyPath: WritableKeyPath<Self, T>, returns mockedValue: T) -> Self {
        var new = self
        new[keyPath: keyPath] = mockedValue
        return new
    }
}
