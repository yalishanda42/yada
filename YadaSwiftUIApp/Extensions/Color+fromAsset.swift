//
//  Color+fromAsset.swift
//  Date Me
//
//  Created by Alexander Ignatov on 19.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

extension Color {
    static func fromAsset(_ asset: Asset) -> Color {
        Color(asset.rawValue)
    }
}

extension Color {
    enum Asset: String {
        case accentOrange = "accent-orange"
        case accentPeachy = "accent-peachy"
        case accentRed = "accent-red"
    }
}
