//
//  RenderableSelectionPicker.swift
//  hackathon-sdui
//
//  Created by Anurag Agnihotri on 11/05/23.
//

import SwiftUI

struct RenderableSelectionPicker: View {
    let model: SelectionPickerModel
    @State var text: String?
    
    var body: some View {
        selectionHStack
        .padding(16)
        .frame(width: model.selectionPickerProperties.size.width,
               height: model.selectionPickerProperties.size.height)
        .background(ColorHelper.swiftUIColor(fromHex:  model.selectionPickerProperties.backgroundColor))
        .cornerRadius(model.selectionPickerProperties.radius)
        .modifier(TapActionModifier(modelID: model.id,
                                    tapAction: model.allowedActionToAction?[.tap],
                                    asyncClosure: { value in
            text = value
        }))
    }
    
    @ViewBuilder
    private var selectionHStack: some View {
        HStack(alignment: .center, spacing: 8) {
            if let leftIcon = model.leftIcon {
                RenderableImage(model: leftIcon)
            }
            VStack(alignment: .leading) {
                Text(text ?? model.placeHolder)
                    .foregroundColor(ColorHelper.swiftUIColor(fromHex:  model.selectionPickerProperties.foregroundColor))
                    .font(FontHelper.swiftUIFont(fromFontProperties: model.selectionPickerProperties.fontProperties))
            }
            Spacer()
            if let rightIcon = model.rightIcon {
                RenderableImage(model: rightIcon)
            }
        }
    }

}
