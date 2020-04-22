//
//  CocktailResult.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 09/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI
import Combine

/*struct LazyView<CocktailResult: View>: View {
    var content: () -> CocktailResult
    var body: some View {
       self.content()
    }
}*/

struct CocktailResult: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userData: UserData
    @State private var ingredientSearchBarContent = ""
    //@ObservedObject var fetcher: CocktailFetcher
    //@Environment(\.imageCache) var cache: ImageCache
    
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    let cocktailRes = ["Cocktail 1", "Cocktail 2"]
    
    @ObservedObject var model: CocktailResultViewModel
    
    
    
    var center = 300.0
    @State var show = false
    
    var body: some View {
        return GeometryReader { geo in
            VStack {
                Spacer()
        
                if !(self.model.items.isEmpty) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 0) {
                        
                            //TODO : SAFE PBROBELM
                            ForEach(self.model.items, id: \.self) { ingredient in
                                CocktailView(model: ingredient)
                                    .frame(width: geo.size.width * 0.90, height: geo.size.height * 0.99, alignment: .bottom)
                                    .shadow(radius: 5)
                            }
                            .offset(x: 30, y: 0)
    
                        }
                    }
                }
            }

        }
    }
}

struct CocktailResult_Previews: PreviewProvider {
    static var previews: some View {
        //let fetcher = CocktailFetcher()
        var item = Items(name: "dfedf")
        var item2 = Items(name: "dfedf")
        
        return ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            CocktailResult(model: CocktailResultViewModel())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
