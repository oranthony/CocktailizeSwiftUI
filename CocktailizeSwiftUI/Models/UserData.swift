//
//  UserData.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 09/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    /*@Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData*/
    
    /**
     Hold the user's ingredients that he entered in the CocktailSearch view
     */
    @Published var selectedIngredients = ["Rum"]
    
    /**
     Hold the latest searched ingredients, displayed in the CocktailSearch view
     */
    @Published var recentIngredients = ["Rum", "Vodka", "Lime"]
    
    @Published var isShowSearch = true
    
    @Published var cocktailColorDictionnary = ["": Color.gray]
    
    @Published var cocktailList = Json4Swift_Base()
}

