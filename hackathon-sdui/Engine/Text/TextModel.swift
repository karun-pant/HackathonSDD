//
//  TextModel.swift
//  hackathon-sdui
//
//  Created by Lakshita Bhardwaj on 11/05/23.
//

import Foundation
import SwiftUI

class TextModel: RenderableModel {
    let text: String
    var textProperties: TextProperties {
        properties as! TextProperties
    }
    override init(_ dictionary: [String : Any]) {
        text = ParsingHelper.asString(item: dictionary["text"])
        super.init(dictionary)
        properties = TextProperties(propertiesDictionary: ParsingHelper.propertiesDictionary(containerDictionary: dictionary))
    }
 
}
    
class TextProperties: RenderableProperties {
    var font: FontProperties?
    var foregroundColor: Color?
    var backgroundColor: Color?
    override init(propertiesDictionary dictionary: [String : Any]) {
        if let fontDictionary = dictionary["font"] as? [String: Any] {
            font = FontProperties(fontPropertiesDictionary: fontDictionary)
        }
        foregroundColor = ColorHelper.swiftUIColor(fromHex: ParsingHelper.asString(item: dictionary["foregroundColor"]))
        backgroundColor = ColorHelper.swiftUIColor(fromHex: ParsingHelper.asString(item: dictionary["backgroundColor"]))
        super.init(propertiesDictionary: dictionary)
    }
}

enum FontStyle: String {
    case bold
    case medium
    case normal
    var fontWeight : Font.Weight {
        switch self {
        case .normal:
            return .regular

        case .bold:
            return .bold

        case .medium:
            return .regular
        }
    }
}

struct TextFont {
    var size: Int
    var type: FontStyle

    init(fontDictionary dictionary: [String: Any]?) {
        self.size = ParsingHelper.asInt(item: dictionary?["size"])
        self.type = FontStyle(rawValue: ParsingHelper.asString(item: dictionary?["type"])) ?? .normal
    }
}
