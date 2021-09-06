//
//  DateMeTests.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 4.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import XCTest
@testable import Date_Me
import Combine
import ComposableArchitecture

class DateMeTests: XCTestCase {
    
    // MARK: - Set up

    override func setUpWithError() throws {
    }
    
    // MARK: - Tear down

    override func tearDownWithError() throws {
    }
    
    // MARK: - Unit Tests: Reducer
    
    func testPresentAuthenticationScreen() throws {
        let store = mockStore(initialState: .init(authScreenIsPresented: false))
        store.send(.showAuthentication) {
            $0.authScreenIsPresented = true
        }
    }

    func testHideAuthenticationScreen() throws {
        let store = mockStore(initialState: .init(authScreenIsPresented: true))
        store.send(.hideAuthentication) {
            $0.authScreenIsPresented = false
        }
    }
    
    func testPresentAlert() throws {
        let store = mockStore(initialState: .init(alertIsPresented: false))
        let message = "Test message 123"
        store.send(.showAlert(message: message)) {
            $0.alertIsPresented = true
            $0.alertTextMessage = message
        }
    }
    
    func testDismissAlert() throws {
        let store = mockStore(initialState: .init(alertIsPresented: true))
        store.send(.hideAlert) {
            $0.alertIsPresented = false
        }
    }
    
    func testTapSettings() throws {
        let store = mockStore(initialState: .init(settingsAreShown: false))
        store.send(.showSettings) {
            $0.settingsAreShown = true
        }
    }
    
    func testPopBackSettings() throws {
        let store = mockStore(initialState: .init(settingsAreShown: true))
        store.send(.hideSettings) {
            $0.settingsAreShown = false
        }
    }
    
    func testSelectTab() throws {
        let store = mockStore()
        let tabs = AppState.Tab.allCases + [.default]
        store.assert(tabs.map { tab in
            .send(.selectTab(tab), { store in store.selectedTab = tab })
        })
    }
    
    func testLoginSuccess() throws {
        let email = "correct@email.com"
        let password = "correct_password"
        let state = AppState(authScreenIsPresented: true)
        let guestState = AppState.GuestUser()
        let action: AppAction = .logIn(email: email, password: password)
        let info = AppAction.AuthenticationInfo()
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedLoginWithEmail, returns: Just(info)
                        .mapError { _ -> AuthenticationError in .unknown }
                        .eraseToAnyPublisher()
                )
        )
        let store = mockStore(initialState: state, mockServices: services)
        
        let expectedUserState: AppState.UserState = .authenticated(.init(with: info, from: guestState))
        
        store.send(action)
        store.receive(.authenticationSuccess(info)) {
            $0.user = expectedUserState
        }
        store.receive(.hideAuthentication) {
            $0.authScreenIsPresented = false
        }
    }
    
    func testLoginError() throws {
        let email = "incorrect@email.com"
        let password = "password"
        let error = AuthenticationError.invalidEmail
        let state = AppState(authScreenIsPresented: true)
        let action: AppAction = .logIn(email: email, password: password)
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedLoginWithEmail, returns: Fail(error: error)
                        .eraseToAnyPublisher()
                )
        )
        let store = mockStore(initialState: state, mockServices: services)
        
        store.send(action)
        store.receive(.showAlert(message: error.localizedErrorMessage)) {
            $0.alertIsPresented = true
            $0.alertTextMessage = error.localizedErrorMessage
        }
    }
    
    func testSignUpSuccess() throws {
        let email = "correct@email.com"
        let password = "correct_password"
        let password2 = "correct_password"
        
        let state = AppState(authScreenIsPresented: true)
        let guestState = AppState.GuestUser()
        let action: AppAction = .signUp(email: email, password: password, passwordRepeated: password2)
        let info = AppAction.AuthenticationInfo()
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedSignUpWithEmail, returns: Just(info)
                        .mapError { _ -> AuthenticationError in .unknown }
                        .eraseToAnyPublisher()
                )
        )
        
        let store = mockStore(initialState: state, mockServices: services)
        
        let expectedUserState: AppState.UserState = .authenticated(.init(with: info, from: guestState))
        
        store.send(action)
        store.receive(.authenticationSuccess(info)) {
            $0.user = expectedUserState
        }
        store.receive(.hideAuthentication) {
            $0.authScreenIsPresented = false
        }
    }
    
    func testSignUpErrorPasswordsEqual() throws {
        let email = "correct@email.com"
        let password = "password"
        let password2 = "incorrect_password"
        let error = AuthenticationError.passwordsDoNotMatch
        let state = AppState(authScreenIsPresented: true)
        let action: AppAction = .signUp(email: email, password: password, passwordRepeated: password2)
        let services = MockServiceDependencies()
        
        let store = mockStore(initialState: state, mockServices: services)
        
        store.send(action)
        store.receive(.showAlert(message: error.localizedErrorMessage)) {
            $0.alertIsPresented = true
            $0.alertTextMessage = error.localizedErrorMessage
        }
    }
    
    func testSignUpErrorEmailInUse() throws {
        let email = "incorrect@email.com"
        let password = "correct_password"
        let password2 = "correct_password"
        let error = AuthenticationError.emailAlreadyInUse
        
        let state = AppState(authScreenIsPresented: true)
        let action: AppAction = .signUp(email: email, password: password, passwordRepeated: password2)
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedSignUpWithEmail, returns: Fail(error: error)
                        .eraseToAnyPublisher()
                )
        )
        
        let store = mockStore(initialState: state, mockServices: services)
        
        store.send(action)
        store.receive(.showAlert(message: error.localizedErrorMessage)) {
            $0.alertIsPresented = true
            $0.alertTextMessage = error.localizedErrorMessage
        }
    }
    
    // MARK: - Helpers
    
    private func mockStore(
        initialState: AppState = .init(),
        mockServices: MockServiceDependencies = .init()
    ) -> TestStore<AppState, AppState, AppAction, AppAction, ServiceDependencies> {
        .init(
            initialState: initialState,
            reducer: AppReducer.reduce,
            environment: mockServices
        )
    }
}
