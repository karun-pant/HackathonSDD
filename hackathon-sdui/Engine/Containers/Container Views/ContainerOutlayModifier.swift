//
//  ContainerOutlayModifier.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 12/05/23.
//

import SwiftUI

struct ContainerOutlayModifier: ViewModifier {
    let properties: ContainerProperties
    func body(content: Content) -> some View {
        switch properties.renderType {
        case .card:
            content
                .padding(properties.radius)
                .background(properties.bgColor)
                .cornerRadius(properties.radius)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
                .padding(properties.padding)
        case .none:
            content
        }
    }
}
