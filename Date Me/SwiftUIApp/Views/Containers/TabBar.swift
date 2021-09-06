//
//  TabBar.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI
import BottomBar_SwiftUI
import ComposableArchitecture

struct TabBar: View {
    
    let store: AppStore
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                NavigationView {
                    viewStore.selectedTab.view(store: store)
                }
                BottomBar(selectedIndex: viewStore.binding(
                    get: {
                        $0.selectedTab.index
                    },
                    send: {
                        .selectTab(AppState.Tab(rawValue: $0) ?? .default)
                    })
                ) {
                    return AppState.Tab.allCases.map { $0.bottomBarItem }
                }
            }.edgesIgnoringSafeArea(.bottom)
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
    
    func view(store: AppStore) -> some View {
        switch self {
        case .messages:
            return MessagesView().eraseToAnyView()
        case .match:
            return MatchView().eraseToAnyView()
        case .account:
            return AccountView(store: store).eraseToAnyView()
        }
    }
}

// MARK: - Previews

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(store: DateMeApp.previewStore())
    }
}
