//
//  VContainerView.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

struct VContainerView: View {
    
    let model: ContainerModel
    let properties: ContainerProperties
    
    var body: some View {
        VStack(alignment: .leading, spacing: properties.interItemSpacing) {
            ViewCreationEngine.makeView(model.children ?? [])
        }
        .modifier(ContainerOutlayModifier(properties: properties))
        .padding(properties.padding)
        .modifier(TapActionModifier(modelID: model.id,
                                    tapAction: model.allowedActionToAction?[.tap],
                                    asyncClosure: nil))
    }
}
