//
//  SearchViewModel.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 14/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    //let objectWillChange = PassthroughSubject<MainViewModel, Never>()
    var lastSearchIngredients = [""]
    var items: [Items]?
    
    //var cocktailTest = CocktailResultViewModel()
    
    //@Published var isSearchHidden = false
    
    init() {
        print("MainModelView init")
    }
    
    func loadCocktail(ingredients: [String], completion: @escaping ([Items]) -> ()) {
        //self.hideSearch()
        DispatchQueue.global(qos: .userInitiated).async {
            // Check is user actually entered ingredients and if those are different from last search
            if (!ingredients.isEmpty && ingredients != self.lastSearchIngredients) {
                //Save new ingredients search
                self.lastSearchIngredients = ingredients
                
                print(ingredients)
                
                //Create param for the query
                var queryParam = ""
                
                for (i, element) in ingredients.enumerated(){
                    queryParam.append(element)
                    if i != ingredients.count - 1 {
                        queryParam.append("%20")
                    }
                }
                
                queryParam = queryParam.replacingOccurrences(of: " ", with: "%20")
                
                // Load cocktail from db with ingredients as param
                guard let url = URL(string: "https://cocktailflow.com/ajax/search/more/cocktail?count=100&phrase=" + queryParam) else {
                    fatalError("URL is not correct!")
                }
                
                // Store result in class property
                Webservice().loadTopHeadlines(url: url) { items in
                    print("webservice called")
                    //self.cocktails.items = items
                    
                    /*if let items = items {
                     self.items = items.map(CocktailViewModel.init)
                     }*/
                    
                    if let items = items {
                        self.items = items
                        completion(items)
                    }
                }
            } else {
                //self.showResult()
                completion([])
            }
        }
        
    }
    

}


class Webservice {
    // TODO: Move to dedicated file
    //TODO: Rename func
    func loadTopHeadlines(url: URL, completion: @escaping ([Items]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let response = try? JSONDecoder().decode(Json4Swift_Base.self, from: data)
            if let response = response {
                DispatchQueue.main.async {
                    print("request completed")
                    //print(response)
                    //self.userData.cocktailList = response
                    completion(response.items)
                }
            }
        }.resume()
        
    }
}
