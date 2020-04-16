//
//  CocktailSearch.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 02/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userData: UserData
    @State private var ingredientSearchBarContent = ""
    @State private var isSearchBarFocused = false
    
    //@ObservedObject var fetcher = CocktailFetcher()
    
    //@State var isShowSearch = true
    
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    var isIngredientEnter = false

    @ObservedObject var model = MainViewModel()
    
    var body: some View {
          NavigationView {
            //TODO: Remove geometry reader ?
              GeometryReader { geo in
                  Image("Background")
                      .resizable()
                      .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        if (self.userData.isShowSearch) {
                            Text("Search ingredients")
                                .font(.largeTitle)
                                .foregroundColor(self.fontColor)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 30.0)
                        }
                            
                        HStack {
                            HStack {
                                Image("Search-icon")
                                TextField("rum", text: self.$ingredientSearchBarContent, onEditingChanged: { (editingChanged) in
                                    if editingChanged {
                                        self.isSearchBarFocused = true
                                        self.userData.isShowSearch = true
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
                                        self.ingredientSearchBarContent = ""
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
                        
                        if (self.userData.isShowSearch) {
                            SearchView()
                        } else {
                            LazyView { CocktailResult() }
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
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
            .environmentObject(userData)
        }
    }
}
