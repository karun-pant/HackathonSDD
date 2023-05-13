//
//  RenderableButton.swift
//  hackathon-sdui
//
//  Created by Lakshita Bhardwaj on 12/05/23.
//

import SwiftUI

struct RenderableButton: View {
    let model: ButtonModel
    var body: some View {
        Button(action: {
            if let onTap = model.allowedActionToAction?[.tap] {
                // Updated value will be returned by this action and that value can be used to update state if needed.
                _ = onTap.closure?(onTap.type,
                                   model.id,
                                   onTap.deeplink,
                                   nil)
            }
        }, label: {
            HStack {
                if model.buttonProperties.titleAlignment == .center || model.buttonProperties.titleAlignment == .trailing {
                    Spacer()
                }
                Text(model.title)
                if model.buttonProperties.titleAlignment == .center || model.buttonProperties.titleAlignment == .leading {
                    Spacer()
                }
            }
            .frame(width: model.buttonProperties.size.width,
                     height: model.buttonProperties.size.height)
                .font(FontHelper.swiftUIFont(fromFontProperties: model.buttonProperties.font))
                .background(model.buttonProperties.backgroundColor)
                .foregroundColor(model.buttonProperties.foregroundColor)
                .cornerRadius(model.buttonProperties.radius)
                .padding(model.buttonProperties.padding)
        })
    }    
}
