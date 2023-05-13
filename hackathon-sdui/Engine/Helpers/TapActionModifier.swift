//
//  TapActionModifier.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 12/05/23.
//

import SwiftUI

struct TapActionModifier: ViewModifier {
    let modelID: String
    let tapAction: Action?
    let asyncClosure: Any?
    
    func body(content: Content) -> some View {
        if let tapAction {
            // Updated value will be returned by this action and that value can be used to update state if needed.
            content
                .onTapGesture {
                    _ = tapAction.closure?(tapAction.type,
                                           modelID,
                                           tapAction.deeplink,
                                           asyncClosure)
                }
        } else {
            content
        }
    }
}
