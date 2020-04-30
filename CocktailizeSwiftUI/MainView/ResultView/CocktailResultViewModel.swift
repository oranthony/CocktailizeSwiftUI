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
    //let objectWillChange = PassthroughSubject<CocktailResultViewModel, Never>()
    
    //@ObservedObject var fetcher = CocktailFetcher()
    
    //TODO: Remove ?
    /*var cocktails = Json4Swift_Base() {
        didSet {
            objectWillChange.send(self)
        }
    }*/
    
    //var items: [CocktailViewModel]
    var items: [Items]
    
    init() {
        print("enter empty init")
        self.items = [Items()]
    }
    
    init(items: [Items] /*cocktailViewModelList: [CocktailViewModel]*/) {
        //print("allo")
        //getCocktails()
        print("ab")
        //var item = [Items(), Items()]
        //self.loadModel(items: item)
        //self.items = item.map(CocktailViewModel.init)
        //self.items = items.map(CocktailViewModel.init)
        
        //self.items = [Items()]
        self.items = items
    }
    
    /*func loadModel(items: [Items]) {
        let item = items.map(CocktailViewModel.init)
        if (self.items != item) {
            print("change value")
            self.items = item
        }
    }*/
    
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


