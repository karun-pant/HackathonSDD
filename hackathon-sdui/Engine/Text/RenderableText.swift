//
//  RenderableText.swift
//  hackathon-sdui
//
//  Created by Lakshita Bhardwaj on 12/05/23.
//

import SwiftUI

struct RenderableText: View {
    let model: TextModel
    
    var body: some View {
        Text(model.text)
            .foregroundColor(model.textProperties.foregroundColor)
            .font(FontHelper.swiftUIFont(fromFontProperties: model.textProperties.font))
            .frame(width: model.textProperties.size.width,
                   height: model.textProperties.size.height)
            .padding(model.textProperties.padding)
        
    }
}
