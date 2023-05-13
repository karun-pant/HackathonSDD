//
//  ImageModel.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

class ImageModel: RenderableModel {
    typealias RenderableContent = RenderableImage
    let link: String
    var imageProperties: ImageProperties {
        properties as! ImageProperties
    }
    override init(_ dictionary: [String : Any]) {
        link = ParsingHelper.asString(item: dictionary["link"])
        super.init(dictionary)
        properties = ImageProperties(propertiesDictionary: ParsingHelper.propertiesDictionary(containerDictionary: dictionary))
    }
}
    
class ImageProperties: RenderableProperties {
    let isNetworkLoadable: Bool
    let radius: CGFloat
    let foreGroundColor: Color?
    let alignment: HorizontalAlignment
    override init(propertiesDictionary dictionary: [String : Any]) {
        isNetworkLoadable = ParsingHelper.asBool(item: dictionary["isNetworkLoadable"])
        radius = ParsingHelper.asCGFloat(item: dictionary["radius"])
        foreGroundColor = {
            let hex = ParsingHelper.asString(item: dictionary["foregroundColor"])
            guard !hex.isEmpty else {
                return nil
            }
            return ColorHelper.swiftUIColor(fromHex: hex)
        }()
        alignment = (ContentAlignment(rawValue: ParsingHelper.asString(item: dictionary["alignment"]).lowercased()) ?? .none).alignment
        super.init(propertiesDictionary: dictionary)
    }
}

