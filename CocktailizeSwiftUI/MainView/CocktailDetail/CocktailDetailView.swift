//
//  CocktailDetailView.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 23/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI

struct CocktailDetailView: View {
    @Binding var showModal: Bool
    @ObservedObject var model: CocktailDetailViewModel
    
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    
    var body: some View {
        GeometryReader { geo in
                   ZStack() {
                       VStack(alignment: .leading) {
                           Spacer()
                           
                           VStack(alignment: .leading, spacing: 0) {
                               VStack(alignment: .leading, spacing: 0) {
                                   Image("Close")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(height: 24)
                                    .onTapGesture {
                                        self.showModal.toggle()
                                }
                                   
                                   ZStack(alignment: Alignment.leading) {
                                       Text("")
                                           .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.37, alignment: .leading)
                                       
                                       Text(self.model.cocktail.name ?? "")
                                           .font(.largeTitle)
                                           .foregroundColor(self.fontColor)
                                           .multilineTextAlignment(.leading)
                                           .frame(maxWidth: geo.size.width * 0.49, maxHeight: geo.size.height * 0.37, alignment: .leading)
                                    
                                   }
                                
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 30.0))
                                    .foregroundColor(Color.pink)
                                    .frame(width: 40, alignment: .center)
                                    .padding(.bottom)
                               }
                               .padding([.top, .leading])
                               
                               Text(self.model.ingredients)
                                    .font(.title)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                    .padding([.top, .leading], 20)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .foregroundColor(self.fontColor)
                                    .background(Color(self.model.backgroundColor))
                                    //.onAppear(perform: {self.model.loadPicture()})
                           }
                           .background(Color.white)
                           //.frame(maxWidth: geo.size.width * 0.91, maxHeight: geo.size.height * 0.95, alignment: .bottomLeading)
                           .cornerRadius(20)
                       }
                       .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                       
                       
                       /*ImageView(withURL: self.model.cocktail.imageUrl ?? "", height: geo.size.height * 0.72)
                           .position(x: geo.size.width * 0.72, y: geo.size.height * 0.19)*/
                    self.model.cocktailImage
                           .position(x: geo.size.width * 0.8, y: geo.size.height * 0.2)
                           
                       /*CocktailPath()
                           .position(x: geo.size.width * 0.70, y: geo.size.height * 0.1)
                           .frame(height: UIScreen.main.bounds.size.height * 0.45)*/
                           
                   }
               }
                .edgesIgnoringSafeArea(.bottom)
        
        
        
        /*VStack {
            Text(self.model.cocktail.name ?? "" )
                .padding()
            // 2.
            Button("Dismiss") {
                self.showModal.toggle()
            }
        }*/
    }
}

struct CocktailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailDetailView(showModal: .constant(true), model: CocktailDetailViewModel(cocktail: Items(), ingredients: "", backgroundColor: UIColor.gray/*, cocktailImage: UIImage(imageLiteralResourceName: "Cocktail-image")*/))
    }
}
