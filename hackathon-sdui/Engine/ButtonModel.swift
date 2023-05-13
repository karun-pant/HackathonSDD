//
//  ButtonModel.swift
//  hackathon-sdui
//
//  Created by Lakshita Bhardwaj on 11/05/23.
//

import Foundation
import SwiftUI

class ButtonModel: RenderableModel {
    let title: String
    var buttonProperties: ButtonProperties {
        properties as! ButtonProperties
    }
    override init(_ dictionary: [String : Any]) {
        title = ParsingHelper.asString(item: dictionary["title"])
        super.init(dictionary)
        properties = ButtonProperties(propertiesDictionary: ParsingHelper.propertiesDictionary(containerDictionary: dictionary))
    }
}
    
class ButtonProperties: RenderableProperties {
   
    var font: FontProperties?
    var deepLink: URL?
    var foregroundColor: Color?
    var backgroundColor: Color?
    var radius: CGFloat
    var titleAlignment: HorizontalAlignment
    override init(propertiesDictionary dictionary: [String : Any]) {
        foregroundColor = ColorHelper.swiftUIColor(fromHex: ParsingHelper.asString(item: dictionary["foregroundColor"]))
        backgroundColor = ColorHelper.swiftUIColor(fromHex: ParsingHelper.asString(item: dictionary["backgroundColor"]))
        if let fontDictionary = dictionary["font"] as? [String: Any] {
                    font = FontProperties(fontPropertiesDictionary: fontDictionary)
        }
        radius = ParsingHelper.asCGFloat(item: dictionary["radius"])
        deepLink = ParsingHelper.asURL(item: dictionary["deeplink"])
        titleAlignment = (ContentAlignment(rawValue: ParsingHelper.asString(item: dictionary["titleAlignment"]).lowercased()) ?? .none).alignment
        super.init(propertiesDictionary: dictionary)
    }
}
