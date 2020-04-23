//
//  CocktailDetailViewModel.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 23/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CocktailDetailViewModel: ObservableObject, Identifiable {
    let objectWillChange = PassthroughSubject<CocktailDetailViewModel, Never>()
    let id = UUID()
    
    var cocktail = Items()
    var cocktailImage: UrlImageView?
    var ingredients: String = ""
    var backgroundColor = UIColor(red: 0.7882, green: 0.7882, blue: 0.7882, alpha: 1.0)
    
    init(cocktail: Items, ingredients: String, backgroundColor: UIColor) {
        self.cocktail = cocktail
        self.backgroundColor = backgroundColor
        self.ingredients = ingredients
        //self.cocktailImage = cocktailImage
        
        loadPicture()
    }
    
    func loadPicture() {
        self.cocktailImage = UrlImageView(urlString: cocktail.imageUrl, height: UIScreen.main.bounds.size.height * 0.6, completionHandler: {_ in})
    }
}
