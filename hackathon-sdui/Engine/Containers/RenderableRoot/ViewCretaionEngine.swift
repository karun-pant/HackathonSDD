//
//  ViewCretaionEngine.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 13/05/23.
//

import SwiftUI

struct ViewCreationEngine {
    @ViewBuilder
    static func makeView(_ children: [RenderableModel]) -> some View {
        ForEach(children, id: \.id) { child in
            switch child.type {
            case .image:
                if let imageModel = child as? ImageModel {
                    RenderableImage(model: imageModel)
                }
            case .vContainer:
                if let child = child as? ContainerModel {
                    VContainerView(model: child, properties: child.containerProperties)
                }
            case .hContainer:
                if let child = child as? ContainerModel {
                    HContainerView(model: child, properties: child.containerProperties)
                }
            case .selectionPicker:
                if let selectionModel = child as? SelectionPickerModel {
                    RenderableSelectionPicker(model: selectionModel,
                                              text: nil)
                    .padding(selectionModel.selectionPickerProperties.padding)
                }
            case .text:

                if let textModel = child as? TextModel {
                    RenderableText(model: textModel)
                }
            case .button:
                if let buttonModel = child as? ButtonModel {
                    RenderableButton(model: buttonModel)
                }
            case .none:
                Text("None")
            }
        }
    }
}
