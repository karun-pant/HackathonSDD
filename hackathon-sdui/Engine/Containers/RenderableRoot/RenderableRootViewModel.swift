//
//  RenderableRootViewModel.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 12/05/23.
//

import Foundation

class RenderableRootViewModel: ObservableObject {
    
    let jsonFile: String
    @Published var result: Result? = nil
    
    
    init(jsonFile: String) {
        self.jsonFile = jsonFile
    }
    
    func loadUX() {
        Parser.readJSON(fileName: jsonFile) { [weak self] result in
            self?.result = result
        }
    }
    
    func traverseAllActions(_ model: RenderableModel,
                            onTap: Action.ActionClosure?,
                            onScroll: Action.ActionClosure?) {
        if let children = model.children {
            for child in children {
                setActions(child.allowedActionToAction,
                           onTap: onTap,
                           onScroll: onScroll)
                traverseAllActions(child,
                                   onTap: onTap,
                                   onScroll: onScroll)
            }
        } else {
            setActions(model.allowedActionToAction,
                       onTap: onTap,
                       onScroll: onScroll)
        }
    }
    private func setActions(_ allowedActionToAction: [ActionType: Action]?,
                            onTap: Action.ActionClosure?,
                            onScroll: Action.ActionClosure?) {
        guard let allowedActionToAction else {
            return
        }
        allowedActionToAction.forEach({ (key, value) in
            switch key {
            case .tap:
                value.closure = onTap
            case .swipe:
                value.closure = onTap
            case .change:
                value.closure = nil
            case .none:
                value.closure = nil
            }
        })
    }
}


class ActionIdentifier {
    let modelId: String
    let deeplink: String?
    init(modelId: String,
         deeplink: String? = nil) {
        self.modelId = modelId
        self.deeplink = deeplink
    }
}
