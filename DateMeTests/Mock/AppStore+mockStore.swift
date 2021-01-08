//
//  AppStore+mockStore.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 5.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import Foundation
import Combine
@testable import Date_Me

extension AppStore {
    static func mockStore(
        initialState: AppState = .init(),
        mockServices: MockServiceDependencies = .init()
    ) -> AppStore {
        .init(initialState: initialState,
              reducer: AppReducer.reduce,
              environment: mockServices
        )
    }
    
    static func mockReduce(
        state: inout AppState,
        action: AppAction,
        environment: ServiceDependencies
    ) -> AnyPublisher<AppAction, Never> {
        AppReducer
            .reduce(state: &state, action: action, environment: environment)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
