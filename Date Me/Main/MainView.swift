//
//  MainView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 20.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        TabView {
            MessagesView().tabItem {
                Image(systemName: "message")
                Text("Messages".localized)
            }
            MatchView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Match".localized)
            }
            AccountView().tabItem {
                Image(systemName: "person")
                Text("Me".localized)
            }
        }.accentColor(.accentPeachy)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
