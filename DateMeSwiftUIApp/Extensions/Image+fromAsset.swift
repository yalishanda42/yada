//
//  Image+fromAsset.swift
//  Date Me
//
//  Created by Alexander Ignatov on 19.07.20.
//  Copyright © 2020 Alexander Ignatov. All rights reserved.
//

import SwiftUI

extension Image {
    static func fromAsset(_ asset: Asset) -> Image {
        Image(asset.rawValue)
    }
}

extension Image {
    enum Asset: String {
        case hearts
        case heartsOutlined = "hearts-outlined"
        case facebook
        case apple
    }
}
