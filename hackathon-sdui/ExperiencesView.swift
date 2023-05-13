//
//  ExperiencesView.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 13/05/23.
//

import SwiftUI

struct ExperiencesView: View {
    
    @Environment(\.openURL) var openURL
    let jsonFile: String
    let title: String
    
    var body: some View {
        NavigationStack {
            RenderableContainerRoot(
                viewModel: RenderableRootViewModel(jsonFile: jsonFile)) { type, modelID, deeplink, asynchronousClosure in
                    if modelID.contains("marketing_banner"), let deeplink {
                        if deeplink.contains("safari") {
                            let url: URL? = {
                                guard deeplink.contains("safari"),
                                      let urlParam = deeplink.components(separatedBy: "?").last?.components(separatedBy: "=").last else {
                                    return nil
                                }
                                return URL(string: urlParam)
                            }()
                            if let url {
                                openURL(url)
                            }
                        }
                    }
                    return nil
                } onScroll: { type, modelID, deeplink, asynchronousClosure in
                    return nil
                }
            
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(ColorHelper.swiftUIColor(fromHex: "#007AFF") ?? Color.blue, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
    }
}
