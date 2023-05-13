//
//  SelectionModel.swift
//  hackathon-sdui
//
//  Created by Anurag Agnihotri on 11/05/23.
//

import SwiftUI

enum FontWeight: String {
    case normal, bold, medium
    
    var systemFontWeight: Font.Weight {
        switch self {
        case .normal:
            return .regular
        case .bold:
            return .bold
        case .medium:
            return .medium
        }
    }
}

class SelectionPickerModel: RenderableModel {
    let placeHolder: String
    let leftIcon: ImageModel?
    let rightIcon: ImageModel?
    var selectionPickerProperties: SelectionPickerProperties {
        properties as! SelectionPickerProperties
    }
    override init(_ dictionary: [String : Any]) {
        placeHolder = ParsingHelper.asString(item: dictionary["placeHolder"])
        leftIcon = {
            guard let leftIconDictionary = dictionary["leftIcon"] as? [String: Any] else {
                return nil
            }
            
            return ImageModel(leftIconDictionary)
        }()
        rightIcon = {
            guard let rightIconDictionary = dictionary["rightIcon"] as? [String: Any] else {
                return nil
            }
            
            return ImageModel(rightIconDictionary)
        }()
        super.init(dictionary)
        properties = SelectionPickerProperties(propertiesDictionary: ParsingHelper.propertiesDictionary(containerDictionary: dictionary))
    }
}

class SelectionPickerProperties: RenderableProperties {
    let foregroundColor: String
    let backgroundColor: String
    let radius: CGFloat
    var fontProperties: FontProperties?
    
    override init(propertiesDictionary dictionary: [String : Any]) {
        foregroundColor = ParsingHelper.asString(item: dictionary["foregroundColor"])
        backgroundColor = ParsingHelper.asString(item: dictionary["backgroundColor"])
        radius = ParsingHelper.asCGFloat(item: dictionary["radius"])
        if let fontDictionary = dictionary["font"] as? [String: Any] {
            fontProperties = FontProperties(fontPropertiesDictionary: fontDictionary)
        }
        super.init(propertiesDictionary: dictionary)
    }
}

class FontProperties {
    let type: FontWeight
    let size: CGFloat
    
    init(fontPropertiesDictionary dictionary: [String: Any]) {
        size = ParsingHelper.asCGFloat(item: dictionary["size"])
        type = FontWeight(rawValue: dictionary["type"] as? String ?? "normal") ?? .normal
    }    
}
