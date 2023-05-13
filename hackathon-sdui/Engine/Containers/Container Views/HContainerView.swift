//
//  HContainerView.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 12/05/23.
//

import SwiftUI

struct HContainerView: View {
    
    let model: ContainerModel
    let properties: ContainerProperties
    
    var body: some View {
        HStack(alignment: .center, spacing: properties.interItemSpacing) {
            ViewCreationEngine.makeView(model.children ?? [])
        }
        .modifier(ContainerOutlayModifier(properties: properties))
        .padding(properties.padding)
        .modifier(TapActionModifier(modelID: model.id,
                                    tapAction: model.allowedActionToAction?[.tap],
                                    asyncClosure: nil))
    }
}
