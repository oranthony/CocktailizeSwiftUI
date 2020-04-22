//
//  ImageLoader.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 13/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String, completionHandler: @escaping (_ result: UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            //TODO: move else where, not in main
            let image = UIImage(data: data) ?? UIImage()
            DispatchQueue.main.async {
                self.data = data
                completionHandler(image)
            }
        }
        task.resume()

    }
}

struct ImageView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    var height: CGFloat
    var url: String
    
    var analizedColor = UIColor.gray

    init(withURL url:String, height: CGFloat, completionHandler: @escaping (_ result: UIImage) -> Void) {
        imageLoader = ImageLoader(urlString:url) {result in
            completionHandler(result)
        }
        self.height = height
        self.url = url
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: height)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
