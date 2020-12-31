//
//  View+customBackButton.swift
//  Date Me
//
//  Created by Alexander Ignatov on 31.12.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

extension View {
    func withCustomBackButton(_ action: @escaping () -> Void) -> some View {
        navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: action) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.init(.systemBlue))
                    Text("navigation.back").foregroundColor(.init(.systemBlue))
                }
            })
    }
}
