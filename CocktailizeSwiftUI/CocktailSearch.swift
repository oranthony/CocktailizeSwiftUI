//
//  CocktailSearch.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 02/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI

struct CocktailSearch: View {
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)

    var body: some View {
          NavigationView {
              GeometryReader { geo in
                  Image("Background")
                  .resizable()
                  .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Search ingredients")
                            .font(.largeTitle)
                            .foregroundColor(self.fontColor)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 30.0)
                        
                        HStack {
                            Image("Search-icon")
                            TextField("", text: .constant("rum")).foregroundColor(self.fontColor)
                        }
                        .padding()
                        .frame(width: (geo.size.width / 3 ) * 2.3, height: 35, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 20).fill(Color.white))
                        .padding(.leading, 30)
                        .padding(.top, -10)
                        .shadow(radius: 4)
                        
                        IngredientRow()
                            .padding([.top, .leading], 30)
                            //.renderingMode(.original)
                            .buttonStyle(PlainButtonStyle())
                        
                        Text("Recentingredients")
                            .font(.title)
                            .foregroundColor(self.fontColor)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 30.0)
                        
                        IngredientRow()
                            .padding(.leading, 30)
                            //.renderingMode(.original)
                            .buttonStyle(PlainButtonStyle())
                    }
                    
                }
                .padding(.vertical, 20.0)
              }
            .hiddenNavigationBarStyle()
          }
        //.navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
        
    }
}

struct CocktailSearch_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            CocktailSearch()
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
