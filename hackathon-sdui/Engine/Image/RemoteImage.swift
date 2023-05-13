//
//  RemoteImage.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import SwiftUI
import UIKit

/// Usages
/// struct ContentView: View {
///    let jsonURL = "https://pic2649952.jpg"
///
///    var body: some View {
///        RemoteSwiftUIImage(url: jsonURL)
///            .aspectRatio(contentMode: .fit)
///            .frame(width: 200)
///    }
/// }
public struct RemoteSwiftUIImage: View {
    
    @ObservedObject private var loader: Loader
    
    public var body: some View {
        selectImage()?.resizable()
    }
    
    public init(urlString: String) {
        _loader = ObservedObject(wrappedValue: Loader(urlString: urlString))
    }
    
    private func selectImage() -> Image? {
        switch loader.state {
        case .loading:
            return Asset.loading.image
        case .failure:
            return Asset.failure.image
        default:
            if let image = loader.image {
                return Image(uiImage: image)
            } else {
                return Asset.failure.image
            }
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

public class Loader: ObservableObject {
    enum LoadState {
        case loading, success, failure
    }
    
    var image: UIImage?
    var state = LoadState.loading
    
    init(urlString: String) {
        guard let parsedURL = URL(string: urlString) else {
            assertionFailure("Invalid URL: \(urlString)")
            return
        }
        
        // check if image exists
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            state = .success
            publish()
        } else {
            URLSession.shared.dataTask(with: parsedURL) { [weak self]  data, _, _ in
                guard let strongSelf = self else {
                    return
                }
                
                if let data = data, !data.isEmpty,
                   let uiImage = UIImage(data: data) {
                    imageCache.setObject(uiImage, forKey: urlString as AnyObject)
                    strongSelf.image = uiImage
                    strongSelf.state = .success
                } else {
                    strongSelf.state = .failure
                }
                strongSelf.publish()
            }.resume()
        }
        
        // setting limit
        if imageCache.countLimit == 0 {
            imageCache.countLimit = 25
        }
    }
    
    private func publish() {
        DispatchQueue.main.async { [weak self] in
            self?.objectWillChange.send()
        }
    }
}
