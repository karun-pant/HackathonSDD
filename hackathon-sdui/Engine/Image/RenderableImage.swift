//
//  RenderableImage.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

struct RenderableImage: View {
    let model: ImageModel
    
    var body: some View {
        VStack(alignment: model.imageProperties.alignment, spacing: 0) {
            image
                .frame(width: model.imageProperties.size.width,
                       height: model.imageProperties.size.height)
        }
        .cornerRadius(model.imageProperties.radius)
        .padding(model.imageProperties.padding)
        .modifier(TapActionModifier(modelID: model.id,
                                    tapAction: model.allowedActionToAction?[.tap],
                                    asyncClosure: nil))
    }
    
    @ViewBuilder
    private var image: some View {
        if model.imageProperties.isNetworkLoadable {
            // Remote Image
            RemoteSwiftUIImage(urlString: model.link)
        } else {
            if let color = model.imageProperties.foreGroundColor {
                Image(model.link)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(color)
            } else {
                Image(model.link)
                    .resizable()
            }
            
        }
    }
}
