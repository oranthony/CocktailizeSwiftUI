//
//  CocktailResultViewModel.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 14/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CocktailResultViewModel: ObservableObject {
    //@EnvironmentObject var userData: UserData
    let objectWillChange = PassthroughSubject<CocktailResultViewModel, Never>()
    
    //@ObservedObject var fetcher = CocktailFetcher()
    
    //TODO: Remove ?
    var cocktails = Json4Swift_Base() {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var items = [CocktailViewModel]()
    
    init() {
        
    }
    
    init(items: [Items]) {
        //print("allo")
        //getCocktails()
        self.items = items.map(CocktailViewModel.init)
    }
    
    /*private func getCocktails() {
        //Create param for the query
        var queryParam = ""
        
        /*for (i, element) in userData.selectedIngredients.enumerated(){
            queryParam.append(element)
            if i != userData.selectedIngredients.count - 1 {
                queryParam.append("%20")
            }
        }
        
        queryParam = queryParam.replacingOccurrences(of: " ", with: "%20")*/
        
        guard let url = URL(string: "https://cocktailflow.com/ajax/search/more/cocktail?count=100&phrase=vodka" + queryParam) else {
            fatalError("URL is not correct!")
        }
        
        Webservice().loadTopHeadlines(url: url) { items in
            self.cocktails.items = items
            
            if let items = items {
                self.items = items.map(CocktailViewModel.init)
            }
            
        }
    }*/
    
    
   
}


