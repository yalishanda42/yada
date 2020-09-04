//
//  View+eraseToAnyView.swift
//  Date Me
//
//  Created by Alexander Ignatov on 4.09.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
