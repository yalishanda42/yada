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
import CombineExpectations

class DateMeTests: XCTestCase {
    
    // MARK: - Set up

    override func setUpWithError() throws {
    }
    
    // MARK: - Tear down

    override func tearDownWithError() throws {
    }
    
    // MARK: - Unit Tests: Reducer
    
    func testReducePresentAuthenticationScreen() throws {
        let store = AppStore.mockStore(initialState: .init(authScreenIsPresented: false))
        store.send(.showAuthentication)
        XCTAssert(store.state.authScreenIsPresented)
    }

    func testReduceHideAuthenticationScreen() throws {
        let store = AppStore.mockStore(initialState: .init(authScreenIsPresented: true))
        store.send(.hideAuthentication)
        XCTAssert(!store.state.authScreenIsPresented)
    }
    
    func testReducePresentAlert() throws {
        let store = AppStore.mockStore(initialState: .init(alertIsPresented: false))
        let message = "Test message 123"
        store.send(.showAlert(message: message))
        XCTAssert(store.state.alertIsPresented)
        XCTAssertEqual(store.state.alertTextMessage, message)
    }
    
    func testReduceDismissAlert() throws {
        let store = AppStore.mockStore(initialState: .init(alertIsPresented: true))
        store.send(.hideAlert)
        XCTAssert(!store.state.alertIsPresented)
    }
    
    func testReduceTapSettings() throws {
        let store = AppStore.mockStore(initialState: .init(settingsAreShown: false))
        store.send(.showSettings)
        XCTAssert(store.state.settingsAreShown)
    }
    
    func testReducePopBackSettings() throws {
        let store = AppStore.mockStore(initialState: .init(settingsAreShown: true))
        store.send(.hideSettings)
        XCTAssert(!store.state.settingsAreShown)
    }
    
    func testReduceSelectTab() throws {
        let store = AppStore.mockStore()
        for tab in AppState.Tab.allCases + [.default] {
            store.send(.selectTab(tab))
            XCTAssertEqual(store.state.selectedTab, tab, "Could not select \(tab)")
        }
    }
    
    func testReduceLoginSuccess() throws {
        let email = "correct@email.com"
        let password = "correct_password"
        var state = AppState(authScreenIsPresented: true)
        let action: AppAction = .logIn(email: email, password: password)
        let info = AppAction.AuthenticationInfo()
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedLoginWithEmail, returns: Just(info)
                        .mapError { _ -> AuthenticationError in .unknown }
                        .eraseToAnyPublisher()
                )
        )
        
        let publisher = AppStore.mockReduce(state: &state, action: action, environment: services)
        let recorder = publisher.record()
        let result = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssertEqual(result, [.authenticationSuccess(info)])
    }
    
    func testReduceLoginError() throws {
        let email = "incorrect@email.com"
        let password = "password"
        let error = AuthenticationError.invalidEmail
        var state = AppState(authScreenIsPresented: true)
        let action: AppAction = .logIn(email: email, password: password)
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedLoginWithEmail, returns: Fail(error: error)
                        .eraseToAnyPublisher()
                )
        )
        
        let publisher = AppStore.mockReduce(state: &state, action: action, environment: services)
        let recorder = publisher.record()
        let result = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssertEqual(result, [.showAlert(message: error.localizedErrorMessage)])
    }
    
    func testReduceSignUpSuccess() throws {
        let email = "correct@email.com"
        let password = "correct_password"
        let password2 = "correct_password"
        
        var state = AppState(authScreenIsPresented: true)
        let action: AppAction = .signUp(email: email, password: password, passwordRepeated: password2)
        let info = AppAction.AuthenticationInfo()
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedSignUpWithEmail, returns: Just(info)
                        .mapError { _ -> AuthenticationError in .unknown }
                        .eraseToAnyPublisher()
                )
        )
        
        let publisher = AppStore.mockReduce(state: &state, action: action, environment: services)
        let recorder = publisher.record()
        let result = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssertEqual(result, [.authenticationSuccess(info)])
    }
    
    func testReduceSignUpErrorPasswordsEqual() throws {
        let email = "correct@email.com"
        let password = "password"
        let password2 = "incorrect_password"
        let error = AuthenticationError.passwordsDoNotMatch
        var state = AppState(authScreenIsPresented: true)
        let action: AppAction = .signUp(email: email, password: password, passwordRepeated: password2)
        let services = MockServiceDependencies()
        
        let publisher = AppStore.mockReduce(state: &state, action: action, environment: services)
        let recorder = publisher.record()
        let result = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssertEqual(result, [.showAlert(message: error.localizedErrorMessage)])
    }
    
    func testReduceSignUpErrorEmailInUse() throws {
        let email = "incorrect@email.com"
        let password = "correct_password"
        let password2 = "correct_password"
        let error = AuthenticationError.emailAlreadyInUse
        
        var state = AppState(authScreenIsPresented: true)
        let action: AppAction = .signUp(email: email, password: password, passwordRepeated: password2)
        let services = MockServiceDependencies(
            authenticationService: MockAuthenticationService()
                .when(\.mockedSignUpWithEmail, returns: Fail(error: error)
                        .eraseToAnyPublisher()
                )
        )
        
        let publisher = AppStore.mockReduce(state: &state, action: action, environment: services)
        let recorder = publisher.record()
        let result = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssertEqual(result, [.showAlert(message: error.localizedErrorMessage)])
    }
    
    func testReduceAuthSuccess() throws {
        let id = "1"
        let email = "correct@email.com"
        let fullName = "AI"
        let guestState = AppState.GuestUser()
        let info = AppAction.AuthenticationInfo(id: id, email: email, fullName: fullName)
        
        var state = AppState(authScreenIsPresented: true, user: .guest(guestState))
        let action: AppAction = .authenticationSuccess(info)
        let services = MockServiceDependencies()
        
        let publisher = AppStore.mockReduce(state: &state, action: action, environment: services)
        let recorder = publisher.record()
        let result = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssertEqual(state.user, .authenticated(.init(with: info, from: guestState)))
        XCTAssertEqual(result, [.hideAuthentication])
    }
}
