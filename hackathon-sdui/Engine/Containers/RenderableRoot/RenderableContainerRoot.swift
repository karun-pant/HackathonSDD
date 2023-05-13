//
//  ContainerView.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI

struct RenderableContainerRoot: View {
    
    @ObservedObject var viewModel: RenderableRootViewModel
    let onTap: Action.ActionClosure?
    let onScroll: Action.ActionClosure?
    
    var body: some View {
        switch viewModel.result {
        case .success(let model):
            VStack(spacing: model.properties?.interItemSpacing) {
                ViewCreationEngine.makeView(model.children ?? [])
                Spacer()
            }
            .padding(model.properties?.padding
                     ?? EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            )
            .modifier(ScrollerIfNeeded(isScrollEnabled: model.properties?.isScrollEnabled))
            .onAppear {
                viewModel.traverseAllActions(model,
                                             onTap: onTap,
                                             onScroll: onScroll)
            }
        case .failure(let error):
            Text(error.description)
        case nil:
            ProgressView().onAppear {
                viewModel.loadUX()
            }
        }
    }
}

struct ScrollerIfNeeded: ViewModifier {
    let isScrollEnabled: Bool?
    func body(content: Content) -> some View {
        if let isScrollEnabled, isScrollEnabled {
            ScrollView {
                content
            }
        } else {
            content
        }
    }
}
