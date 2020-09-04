//
//  TabBar.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct TabBar: View {
        
    var body: some View {
        TabView {
            MessagesView().tabItem {
                Image(systemName: "message")
                Text("Messages")
            }
            MatchView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Match")
            }
            AccountView().tabItem {
                Image(systemName: "person")
                Text("Me")
            }
        }.accentColor(.fromAsset(.accentPeachy))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
