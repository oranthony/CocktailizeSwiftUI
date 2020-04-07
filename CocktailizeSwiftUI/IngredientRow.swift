//
//  IngredientRow.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 04/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI

struct IngredientRow: View {
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    var items = ["rum", "banana"]
    
    var body: some View {
        VStack(alignment: .leading) {
            /*Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)*/
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items, id: \.self) { ingredient in
                        NavigationLink(
                        destination: CocktailizeHome()) {
                            CategoryItem()
                        }
                        .padding(.trailing, 33)
                    }
                }
            }
            .frame(height: 112)
            
        }
        //CategoryItem()
    }
}

struct CategoryItem: View {
    
    //var landmark: Landmark
    
    var body: some View {
        VStack {
            Text("Rum")
                .font(.system(size: 22))
                .fontWeight(.light)
                .foregroundColor(Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0))
                .padding(.top, 30.0)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: {
                 print("button pressed")
             }) {
                Text("Remove")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .multilineTextAlignment(.trailing)
                    
            }
            .padding(.top, 20)
            .padding(.trailing, 12)
            .frame(maxWidth: .infinity, alignment: .trailing)
            //.renderingMode(.original)
            //.buttonStyle(PlainButtonStyle())

        }
        .frame(width: 112, height: 112, alignment: .leading)
        .background(Color.white)
        .cornerRadius(19)
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow()
    }
}
