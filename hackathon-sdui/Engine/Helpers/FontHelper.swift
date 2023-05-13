//
//  Font.swift
//  hackathon-sdui
//
//  Created by Anurag Agnihotri on 11/05/23.
//

import SwiftUI

struct FontHelper {
    
    static func swiftUIFont(fromFontProperties properties: FontProperties?) -> Font? {
        guard let properties else {
            return nil
            
        }
        return .system(size: properties.size,
                       weight: properties.type.systemFontWeight)
    }
}
