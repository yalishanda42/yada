//
//  RootView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
    
    private var currentView: some View {
        viewModel.authenticationIsPresented
            ? AnyView(AuthenticationView(viewModel: viewModel.authenticationViewModel))
            : AnyView(MainView(viewModel: viewModel.mainViewModel))
    }
    
    var body: some View {
        currentView.alert(isPresented: $viewModel.simpleAlertIsPresented) {
            Alert(
                title: Text("Error".localized),
                message: Text(viewModel.simpleAlertText),
                dismissButton: .default(Text("OK".localized),
                                        action: { self.viewModel.simpleAlertIsPresented = false })
            )
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel(authenticationService: PreviewAuthenticationService()))
    }
}
