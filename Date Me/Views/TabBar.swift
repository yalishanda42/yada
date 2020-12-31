//
//  TabBar.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI
import BottomBar_SwiftUI

struct TabBar: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            NavigationView {
                store.state.selectedTab.view
            }
            BottomBar(selectedIndex: store.selectedTabIndexBinding) {
                return AppState.Tab.allCases.map { $0.bottomBarItem }
            }
        }
    }
}

extension AppState.Tab {
    var icon: Image {
        switch self {
        case .messages:
            return .init(systemName: "message")
        case .match:
            return .init(systemName: "magnifyingglass")
        case .account:
            return .init(systemName: "person")
        }
    }
    
    var localizedTitle: String {
        switch self {
        case .messages:
            return "tab.messages".localized
        case .match:
            return "tab.match".localized
        case .account:
            return "tab.account".localized
        }
    }
    
    var bottomBarItem: BottomBarItem {
        .init(icon: icon, title: localizedTitle, color: .fromAsset(.accentPeachy))
    }
    
    var view: some View {
        switch self {
        case .messages:
            return MessagesView().eraseToAnyView()
        case .match:
            return MatchView().eraseToAnyView()
        case .account:
            return AccountView().eraseToAnyView()
        }
    }
}

// MARK: - Previews

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(DateMeApp.previewStore())
    }
}

// MARK: - Helpers

extension AppStore {
    var selectedTabIndexBinding: Binding<Int> {
        .init {
            self.state.selectedTab.index
        } set: { newIndex in
            if let newTab = AppState.Tab(rawValue: newIndex) {
                self.send(.selectTab(newTab))
            }
        }
    }
}
