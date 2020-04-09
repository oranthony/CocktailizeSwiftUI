//
//  CocktailSearch.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 02/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI

struct CocktailSearch: View {
    @EnvironmentObject var userData: UserData
    @State private var ingredientSearchBarContent = ""
    @State private var isSearchBarFocused = false
    
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    var isIngredientEnter = false

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
                            HStack {
                                Image("Search-icon")
                                TextField("rum", text: self.$ingredientSearchBarContent, onEditingChanged: { (editingChanged) in
                                    if editingChanged {
                                        self.isSearchBarFocused = true
                                    } else {
                                        self.isSearchBarFocused = false
                                    }
                                }, onCommit: {
                                    self.userData.selectedIngredients.append(self.ingredientSearchBarContent)
                                    self.isSearchBarFocused = false
                                    print(self.ingredientSearchBarContent)
                                    print(self.userData.selectedIngredients)
                                })
                                
                                Spacer()

                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.secondary)
                                    .opacity(self.ingredientSearchBarContent == "" ? 0 : 1)
                                    .onTapGesture { self.ingredientSearchBarContent = "" }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 20).fill(Color.white))
                            .padding(.top, -10)
                            .padding(.leading, 30.0)
                            .shadow(radius: 4)
                            
                            if (self.isSearchBarFocused) {
                                Text("Cancel")
                                    .frame(width: 70, alignment: .center)
                                    .onTapGesture {
                                        self.dismissKeyboard()
                                        self.isSearchBarFocused = false
                                    }
                                    .padding(.top, -15)
                                    .padding(.trailing, 10)
                            } else {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 30.0))
                                    .foregroundColor(Color.pink)
                                    .frame(width: 40, alignment: .center)
                                    .padding(.top, -10)
                                    .padding(.trailing, 10)
                            }
                        }
                        
                        SelectedIngredientsRow()
                            .padding(.top, 30)
                            .buttonStyle(PlainButtonStyle())
                        
                        if (self.userData.recentIngredients.count > 0) {
                            Text("Recent ingredients")
                                .font(.title)
                                .foregroundColor(self.fontColor)
                                .multilineTextAlignment(.leading)
                                .padding([.leading, .top], 30.0)
                        }
                        
                        RecentIngredientRow()
                            .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        if (self.userData.selectedIngredients.count == 0) {
                            Text("Use the search bar to add ingredients")
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding([.leading, .trailing], 30)
                        } else {
                            NavigationLink(destination: CocktailSearch()) {
                                Text("Search")
                                    .fontWeight(.semibold)
                                    .font(.title)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding(.vertical, 9.0)
                                    .foregroundColor(Color(red:0.44, green:0.44, blue:0.44, opacity:1))
                                    .background(Color(red:0.49, green:0.87, blue:0.94, opacity:0.99))
                                    .cornerRadius(40)
                                    .shadow(radius: 2)
                                    .padding(.horizontal, 50.0)
                            }
                            //.padding(.bottom, geo.size.height / 20)
                            .navigationBarBackButtonHidden(true) // TODO: remove ?
                        }
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
    
    func dismissKeyboard() {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.endEditing(true)
    }
}

struct CocktailSearch_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            CocktailSearch()
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
