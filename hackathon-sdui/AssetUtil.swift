//
//  AssetUtil.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

public enum Asset: String {
    // Add all the asset image names here
    case failure = "error"
    case loading = "loading"

    // MARK: -
    // to access images use PLTripImage.calender.image (swiftUI) or PLTripImage.calender.uiImage (UIImage)
    public var image: Image {
        Image(self.rawValue, bundle: Bundle.main)
    }
}
