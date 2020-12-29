//
//  RootView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var store: AppStore
    
    private var currentView: some View {
        store.state.authScreenIsPresented
            ? AuthenticationView().eraseToAnyView()
            : TabBar().eraseToAnyView()
    }
    
    var body: some View {
        currentView.alert(isPresented: .constant(store.state.alertIsPresented)) {
            Alert(
                title: Text("Error"),
                message: Text(store.state.alertTextMessage),
                dismissButton: .default(Text("OK"),
                    action: {
                        self.store.send(.dismissAlert)
                    }
                )
            )
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(DateMeApp.previewStore())
    }
}
