//
//  RenderableModelBase.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

enum RenderableType: String {
    case vContainer, hContainer, selectionPicker, text, button, image, none
}
enum ActionType: String {
    case tap, swipe, change, none
}

class RenderableModel: Identifiable {
    let id: String
    let type: RenderableType
    var children: [RenderableModel]?
    var properties: RenderableProperties?
    var allowedActionToAction: [ActionType: Action]?
    init(_ dictionary: [String: Any]) {
        id = ParsingHelper.asString(item: dictionary["id"])
        type = RenderableType(rawValue: ParsingHelper.asString(item: dictionary["type"])) ?? .none
        allowedActionToAction = {
            guard let actionObjects = dictionary["allowedActions"] as? [[String: Any]] else {
                return nil
            }
            var allowedActionToAction = [ActionType: Action]()
            actionObjects.forEach {
                let action = Action($0)
                allowedActionToAction[action.type] = action
            }
            return allowedActionToAction
        }()
        children = {
            guard let childObjects = dictionary["children"] as? [[String: Any]] else {
                return nil
            }
            return childObjects.compactMap { child in
                let type = RenderableType(rawValue: ParsingHelper.asString(item: child["type"])) ?? .none
                switch type {
                case .vContainer:
                    return ContainerModel(child)
                case .hContainer:
                    return ContainerModel(child)
                case .selectionPicker:
                    return SelectionPickerModel(child)
                case .text:
                    return TextModel(child)
                case .button:
                    return ButtonModel(child)
                case .image:
                    return ImageModel(child)
                case .none:
                    return nil
                }
            }
        }()
        properties = RenderableProperties(propertiesDictionary: ParsingHelper.propertiesDictionary(containerDictionary: dictionary))
    }
}

class Action {
    typealias ActionClosure = (_ type: ActionType,
                               _ modelID: String,
                               _ deeplink: String?,
                               _ asynchronousClosure: Any?) -> (Any?)
    let type: ActionType
    let deeplink: String?
    var closure: ActionClosure?
    init(_ dictionary: [String: Any]) {
        type = ActionType(rawValue: ParsingHelper.asString(item: dictionary["type"])) ?? .none
        deeplink = dictionary["deeplink"] as? String
    }
}

class RenderableProperties {
    let isScrollEnabled: Bool
    let isTappable: Bool
    let size: Size
    let padding: EdgeInsets
    let interItemSpacing: CGFloat
    
    init(propertiesDictionary dictionary: [String: Any]) {
        interItemSpacing = ParsingHelper.asCGFloat(item: dictionary["interItemSpacing"])
        isScrollEnabled = ParsingHelper.asBool(item: dictionary["scrollEnabled"])
        isTappable = ParsingHelper.asBool(item: dictionary["isTapabble"])
        size = Size(sizeDictionary: dictionary["size"] as? [String: Any])
        padding = {
            guard let paddingDictionary = dictionary["padding"] as? [String: Any] else {
                return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            }
            return .init(top: ParsingHelper.asCGFloat(item: paddingDictionary["top"]),
                         leading: ParsingHelper.asCGFloat(item: paddingDictionary["left"]),
                         bottom: ParsingHelper.asCGFloat(item: paddingDictionary["bottom"]),
                         trailing: ParsingHelper.asCGFloat(item: paddingDictionary["right"]))
        }()
    }
}

class Size {
    let width: CGFloat?
    let height: CGFloat?
    init(sizeDictionary dictionary: [String: Any]?) {
        width = dictionary?["width"] as? CGFloat
        height = dictionary?["height"] as? CGFloat
    }
}

enum ContentAlignment: String {
    case left, right, center, none
    var alignment: HorizontalAlignment {
        switch self {
        case .left:
            return .leading
        case .right:
            return .trailing
        case .center:
            return .center
        case .none:
            return .center
        }
    }
}
