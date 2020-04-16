//
//  CocktailViewModel.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 14/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UIImageColors

class CocktailViewModel: ObservableObject, Identifiable, Hashable {
    let objectWillChange = PassthroughSubject<CocktailViewModel, Never>()
    
    let id = UUID()
    var cocktailImage: ImageView?
    var cocktail = Items()
    @Published var backgroundColor = UIColor.gray {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    static func == (lhs: CocktailViewModel, rhs: CocktailViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    //TODO: deprecated, to change
    var hashValue: Int {
        return id.hashValue ^ cocktail.hashValue
    }
    
    init() {
        print(cocktail)
        self.cocktailImage = ImageView(withURL: "", height: 0) {_ in }
    }
    
    init(cocktail: Items) {
        self.cocktail = cocktail
        //TODO: remove height from initializer && set default image with an actual image
        
        //backgroundColor = setBackgroundColor()
        loadPicture()
    }
    
    func loadPicture() {
        self.cocktailImage = ImageView(withURL: cocktail.imageUrl ?? "", height: (UIScreen.main.bounds.size.height * 0.55)) {result in
            self.backgroundColor = self.setBackgroundColor(image: result)
            //setBackgroundColor(image: result)
        }
    }
    
    func setBackgroundColor(image: UIImage) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        image.getColors()!.background.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let color = UIColor(hue: hue, saturation: 0.28, brightness: 1, alpha: 1)
        return color
    }
    
}
