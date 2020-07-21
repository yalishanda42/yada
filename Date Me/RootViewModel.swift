//
//  RootViewModel.swift
//  Date Me
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import Combine

class RootViewModel: ObservableObject {
    @Published var authenticationIsPresented = true
    let authenticationViewModel = AuthenticationViewModel()
    let mainViewModel = MainViewModel()
       
   private var disposeBag: Set<AnyCancellable> = []
   
   init() {
       authenticationViewModel.signInFinished.sink { [weak self] _ in
           self?.authenticationIsPresented = false
       }.store(in: &disposeBag)
   }
}
