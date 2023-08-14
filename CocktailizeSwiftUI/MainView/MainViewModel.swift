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
    
    init() {
        
    }
    
    func loadCocktail(ingredients: [String], completion: @escaping ([Items]) -> ()) {
        
        if (!ingredients.isEmpty && ingredients != self.lastSearchIngredients) {
            // Check if user actually entered ingredients and if those are different from last search
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Save new ingredients search
                self.lastSearchIngredients = ingredients
                
                // Create param for the query
                var queryParam = ""
                
                // Transform array of ingredients into a string. Each ingredient separated by a space
                for (i, element) in ingredients.enumerated(){
                    queryParam.append(element)
                    if i != ingredients.count - 1 {
                        queryParam.append(" ")
                    }
                }
                
                //queryParam = queryParam.replacingOccurrences(of: " ", with: "%20")
                //queryParam = queryParam.convertedToSlug() ?? queryParam
                
                // Building the url
                var uc = URLComponents()
                uc.scheme = "https"
                uc.host = "cocktailflow.com"
                uc.path = "/ajax/search/more/cocktail"
                uc.queryItems = [
                    URLQueryItem(name: "count", value: "100"),
                    URLQueryItem(name: "phrase", value: queryParam),
                    
                ]
                
                // Load cocktail from db with ingredients as param
                guard let url = URL(string: uc.url!.absoluteString) else {
                    fatalError("URL is not correct!")
                }
                
                print("url :", url);
                
                // Store result in class property
                Webservice().loadTopHeadlines(url: url) { items in
                    if let items = items {
                        self.items = items
                        completion(items)
                    }
                }
            }
        } else {
            print("else");
            completion([])
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
                    completion(response.items)
                }
            }
        }.resume()
        
    }
}

extension String {
    private static let slugSafeCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-")

    public func convertedToSlug() -> String? {
        if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
            let urlComponents = latin.components(separatedBy: String.slugSafeCharacters.inverted)
            let result = urlComponents.filter { $0 != "" }.joined(separator: "-")

            if result.count > 0 {
                return result
            }
        }

        return nil
    }
}
