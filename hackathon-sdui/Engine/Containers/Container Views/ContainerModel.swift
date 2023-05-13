//
//  ContainerModel.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

enum ContainerOutlayType: String {
    case card, none
}

class ContainerModel: RenderableModel {
    typealias RenderableContent = RenderableImage
    var containerProperties: ContainerProperties {
        properties as! ContainerProperties
    }
    override init(_ dictionary: [String : Any]) {
        super.init(dictionary)
        properties = ContainerProperties(propertiesDictionary: ParsingHelper.propertiesDictionary(containerDictionary: dictionary))
    }
}
    
class ContainerProperties: RenderableProperties {
    let renderType: ContainerOutlayType
    let bgColor: Color
    let radius: CGFloat
    override init(propertiesDictionary dictionary: [String : Any]) {
        radius = ParsingHelper.asCGFloat(item: dictionary["radius"])
        renderType = ContainerOutlayType(rawValue: ParsingHelper.asString(item: dictionary["renderType"])) ?? .none
        bgColor = ColorHelper.swiftUIColor(fromHex: ParsingHelper.asString(item: dictionary["backgroundColor"])) ?? .white
        super.init(propertiesDictionary: dictionary)
    }
}
