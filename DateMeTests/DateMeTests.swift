//
//  DateMeTests.swift
//  DateMeTests
//
//  Created by Alexander Ignatov on 4.01.21.
//  Copyright © 2021 Alexander Ignatov. All rights reserved.
//

import XCTest
@testable import Date_Me

class DateMeTests: XCTestCase {
    
    // MARK: - Properties
    
    private var store: AppStore!
    
    // MARK: - Set up

    override func setUpWithError() throws {
        store = DateMeApp.previewStore()
        // TODO Use a different environment for a test store?
    }
    
    // MARK: - Tear down

    override func tearDownWithError() throws {
    }
    
    // MARK: - Unit Tests: Reducer
    
    func testReducePresentAuthenticationScreen() throws {
        store.send(.presentAuthenticationScreen)
        XCTAssert(store.state.authScreenIsPresented)
    }

    func testReduceHideAuthenticationScreen() throws {
        store.send(.hideAuthenticationScreen)
        XCTAssert(!store.state.authScreenIsPresented)
    }
    
    func testReducePresentAlert() throws {
        let message = "Test message 123"
        store.send(.presentAlert(message: message))
        XCTAssert(store.state.alertIsPresented)
        XCTAssertEqual(store.state.alertTextMessage, message)
    }
    
    func testReduceDismissAlert() throws {
        store.send(.dismissAlert)
        XCTAssert(!store.state.alertIsPresented)
    }
    
    func testReduceTapSettings() throws {
        store.send(.tapSettings)
        XCTAssert(store.state.settingsAreShown)
    }
    
    func testReducePopBackSettings() throws {
        store.send(.popBackSettings)
        XCTAssert(!store.state.settingsAreShown)
    }
    
    func testReduceSelectTab() throws {
        for tab in AppState.Tab.allCases {
            store.send(.selectTab(tab))
            XCTAssertEqual(store.state.selectedTab, tab, "Could not select \(tab)")
        }
    }
}
