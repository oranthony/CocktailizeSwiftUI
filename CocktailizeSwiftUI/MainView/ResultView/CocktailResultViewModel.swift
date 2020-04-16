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
        
    let objectWillChange = PassthroughSubject<CocktailResultViewModel, Never>()
    
    //@ObservedObject var fetcher = CocktailFetcher()
    
    var cocktails = Json4Swift_Base() {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var items = [CocktailViewModel]()
    
    init() {
        print("allo")
        getCocktails()
    }
    
    private func getCocktails() {
        print("start request")
        guard let url = URL(string: "https://cocktailflow.com/ajax/search/more/cocktail?count=100&phrase=vodka") else {
            fatalError("URL is not correct!")
        }
        
        Webservice().loadTopHeadlines(url: url) { items in
            self.cocktails.items = items
            
            if let items = items {
                self.items = items.map(CocktailViewModel.init)
            }
            
        }
    }
    
    
   
}


class Webservice {
    // TODO: Move to dedicated file
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
