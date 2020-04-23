//
//  CocktailView.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 09/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI
import ShimmerView

struct CocktailView: View {
    @EnvironmentObject var userData: UserData
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    //let cocktail: Items
    let receipe =
    "-azza \n"
    + "-dfvdf \n"
    + "-dferferf \n"
    
    @State var show = true
    var center = (UIScreen.main.bounds.width / 2) + 110
    
    @ObservedObject var model: CocktailViewModel
    
    @State private var showModal = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack() {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            /*Image("Close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)*/
                            
                            ZStack(alignment: Alignment.leading) {
                                Text("")
                                    .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.45, alignment: .leading)
                                
                                Text(self.model.cocktail.name ?? "")
                                    .font(.largeTitle)
                                    .foregroundColor(self.fontColor)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: geo.size.width * 0.49, maxHeight: geo.size.height * 0.45, alignment: .leading)
                                
                                /*Image(systemName: "heart.fill")
                                .font(.system(size: 30.0))
                                .foregroundColor(Color.pink)
                                .frame(width: 40, alignment: .center)
                                .padding(.top, -10)
                                .padding(.trailing, 10)*/
                            }
                        }
                        .padding([.top, .leading])
                        
                        Text(self.model.ingredients)
                            .font(.title)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading])
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .foregroundColor(self.fontColor)
                            .background(Color(self.model.backgroundColor))
                            //.onAppear(perform: {self.model.loadPicture()})
                    }
                    .background(Color.white)
                    .frame(maxWidth: geo.size.width * 0.91, maxHeight: geo.size.height * 0.95, alignment: .bottomLeading)
                    .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                
                
                /*ImageView(withURL: self.model.cocktail.imageUrl ?? "", height: geo.size.height * 0.72)
                    .position(x: geo.size.width * 0.72, y: geo.size.height * 0.19)*/
                /*self.model.cocktailImage
                    .position(x: geo.size.width * 0.72, y: geo.size.height * 0.19)*/
                
                //UrlImageView(urlString: self.model.cocktail.imageUrl, height: UIScreen.main.bounds.size.height * 0.55)
                self.model.cocktailImage
                    .position(x: geo.size.width * 0.72, y: geo.size.height * 0.19)
                    
                /*CocktailPath()
                    .position(x: geo.size.width * 0.70, y: geo.size.height * 0.1)
                    .frame(height: UIScreen.main.bounds.size.height * 0.45)*/
                    
            }.onTapGesture {
                 self.showModal.toggle()
            }.sheet(isPresented: self.$showModal) {
                CocktailDetailView(showModal: self.$showModal, model: CocktailDetailViewModel(cocktail: self.model.cocktail, ingredients: self.model.ingredients, backgroundColor: self.model.backgroundColor/*, cocktailImage: self.model.cocktailImage!.image*/))
            }
        }
        //.environmentObject(ShimmerConfig())
    }
    
}

struct CocktailView_Previews: PreviewProvider {
    static var previews: some View {
        let cocktail = CocktailViewModel()
        return ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            CocktailView(model: cocktail)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}