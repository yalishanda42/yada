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
    
    var body: some View {
        viewModel.authenticationIsPresented
            ? AnyView(AuthenticationView(viewModel: viewModel.authenticationViewModel))
            : AnyView(MainView(viewModel: viewModel.mainViewModel))
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel())
    }
}
