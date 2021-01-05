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
        store.send(.presentAuthenticationScreen)
        XCTAssert(store.state.authScreenIsPresented)
    }

    func testReduceHideAuthenticationScreen() throws {
        let store = AppStore.mockStore(initialState: .init(authScreenIsPresented: true))
        store.send(.hideAuthenticationScreen)
        XCTAssert(!store.state.authScreenIsPresented)
    }
    
    func testReducePresentAlert() throws {
        let store = AppStore.mockStore(initialState: .init(alertIsPresented: false))
        let message = "Test message 123"
        store.send(.presentAlert(message: message))
        XCTAssert(store.state.alertIsPresented)
        XCTAssertEqual(store.state.alertTextMessage, message)
    }
    
    func testReduceDismissAlert() throws {
        let store = AppStore.mockStore(initialState: .init(alertIsPresented: true))
        store.send(.dismissAlert)
        XCTAssert(!store.state.alertIsPresented)
    }
    
    func testReduceTapSettings() throws {
        let store = AppStore.mockStore(initialState: .init(settingsAreShown: false))
        store.send(.tapSettings)
        XCTAssert(store.state.settingsAreShown)
    }
    
    func testReducePopBackSettings() throws {
        let store = AppStore.mockStore(initialState: .init(settingsAreShown: true))
        store.send(.popBackSettings)
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
        let store = AppStore.mockStore(
            initialState: .init(
                authScreenIsPresented: true
            ),
            mockServices: .init(
                authenticationService: MockAuthenticationService()
                    .when(\.mockedLoginWithEmail, returns: Just(())
                            .mapError{_ in .unknown}
                            .eraseToAnyPublisher()
                    )
            )
        )
        
        let publisher = store.obtainReducerPublisher(.logIn(email: email, password: password))
        let recorder = publisher.record()
        store.applyReducerPublisher(publisher)
        let _ = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssert(!store.state.authScreenIsPresented)
        XCTAssert(!store.state.alertIsPresented)
    }
    
    func testReduceLoginError() throws {
        let email = "incorrect@email.com"
        let password = "password"
        let error = AuthenticationError.invalidEmail
        let store = AppStore.mockStore(
            initialState: .init(
                authScreenIsPresented: true
            ),
            mockServices: .init(
                authenticationService: MockAuthenticationService()
                    .when(\.mockedLoginWithEmail, returns: Fail(error: error)
                            .eraseToAnyPublisher()
                    )
            )
        )
        
        let publisher = store.obtainReducerPublisher(.logIn(email: email, password: password))
        let recorder = publisher.record()
        store.applyReducerPublisher(publisher)
        let _ = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssert(store.state.authScreenIsPresented)
        XCTAssert(store.state.alertIsPresented)
        XCTAssertEqual(store.state.alertTextMessage, error.localizedErrorMessage)
    }
    
    func testReduceSignUpSuccess() throws {
        let email = "correct@email.com"
        let password = "correct_password"
        let password2 = "correct_password"
        let store = AppStore.mockStore(
            initialState: .init(
                authScreenIsPresented: true
            ),
            mockServices: .init(
                authenticationService: MockAuthenticationService()
                    .when(\.mockedSignUpWithEmail, returns: Just(())
                            .mapError{_ in .unknown}
                            .eraseToAnyPublisher()
                    )
            )
        )
        
        let publisher = store.obtainReducerPublisher(.signUp(email: email, password: password, passwordRepeated: password2))
        let recorder = publisher.record()
        store.applyReducerPublisher(publisher)
        let _ = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssert(!store.state.authScreenIsPresented)
        XCTAssert(!store.state.alertIsPresented)
    }
    
    func testReduceSignUpErrorPasswordsEqual() throws {
        let email = "correct@email.com"
        let password = "password"
        let password2 = "incorrect_password"
        let error = AuthenticationError.passwordsDoNotMatch
        let store = AppStore.mockStore(
            initialState: .init(
                authScreenIsPresented: true
            ),
            mockServices: .init()
        )
        
        let publisher = store.obtainReducerPublisher(.signUp(email: email, password: password, passwordRepeated: password2))
        let recorder = publisher.record()
        store.applyReducerPublisher(publisher)
        let _ = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssert(store.state.authScreenIsPresented)
        XCTAssert(store.state.alertIsPresented)
        XCTAssertEqual(store.state.alertTextMessage, error.localizedErrorMessage)
    }
    
    func testReduceSignUpErrorEmailInUse() throws {
        let email = "incorrect@email.com"
        let password = "correct_password"
        let password2 = "correct_password"
        let error = AuthenticationError.emailAlreadyInUse
        let store = AppStore.mockStore(
            initialState: .init(
                authScreenIsPresented: true
            ),
            mockServices: .init(
                authenticationService: MockAuthenticationService()
                    .when(\.mockedSignUpWithEmail, returns: Fail(error: error)
                            .eraseToAnyPublisher()
                    )
            )
        )
        
        let publisher = store.obtainReducerPublisher(.signUp(email: email, password: password, passwordRepeated: password2))
        let recorder = publisher.record()
        store.applyReducerPublisher(publisher)
        let _ = try wait(for: recorder.elements, timeout: 0.5)
        
        XCTAssert(store.state.authScreenIsPresented)
        XCTAssert(store.state.alertIsPresented)
        XCTAssertEqual(store.state.alertTextMessage, error.localizedErrorMessage)
    }
}
