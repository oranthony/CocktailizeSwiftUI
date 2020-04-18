//
//  CocktailSearch.swift
//  CocktailizeSwiftUI
//
//  Created by anthony loroscio on 02/04/2020.
//  Copyright © 2020 anthony loroscio. All rights reserved.
//

import SwiftUI

// Share function with child view (SearchView) to trigger cocktails search
struct StartSearchFunctionKey: EnvironmentKey {
    static let defaultValue: (() -> Void)? = nil
}

extension EnvironmentValues {
    var startSearchFunction: (() -> Void)? {
        get { self[StartSearchFunctionKey.self] }
        set { self[StartSearchFunctionKey.self] = newValue }
    }
}


struct MainView: View {
    @EnvironmentObject var userData: UserData
    @State private var ingredientSearchBarContent = ""
    @State private var isSearchBarFocused = false
    
    let fontColor = Color(red:0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    var isIngredientEnter = false

    @ObservedObject var model = MainViewModel()
    
    // Triggered when user click on start on SearchView (via environment key)
    func startSearchFunction() {
        self.model.hideSearch()
        // Call model load function with param from env object and then display SearchView
        model.loadCocktail(ingredients: userData.selectedIngredients) {
            self.userData.isShowSearch = false
        }
    }
    
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
                                        /*self.model.hideResult()
                                        self.model.showSearch()*/
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
                        
                       /* if (self.userData.isShowSearch) {
                            SearchView()
                        } else {
                            LazyView { CocktailResult(model: CocktailResultViewModel(items: self.model.items)) }
                        }*/
                        
                        ZStack {
                            /*SearchView().offset(x: self.model.searchOffset).animation(.easeIn(duration: 0.8))
                            
                            LazyView { CocktailResult(model: CocktailResultViewModel(items: self.model.items)) }.offset(x: self.model.resultOffset).animation(.easeOut(duration: 0.8))*/
                            
                            SearchView().offset(x: self.userData.isShowSearch ? 0 : -UIScreen.main.bounds.width ).animation(.easeIn(duration: 0.5))
                            
                            LazyView { CocktailResult(model: CocktailResultViewModel(items: self.model.items)) }.offset(x: !self.userData.isShowSearch ? 0 : UIScreen.main.bounds.width).animation(.easeOut(duration: 0.5))
                            
                            
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
        .environment(\.startSearchFunction, startSearchFunction)
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

extension AnyTransition {
  static var customTransition: AnyTransition {
    let transition = AnyTransition.move(edge: .top)
      .combined(with: .scale(scale: 0.2, anchor: .topTrailing))
      .combined(with: .opacity)
    return transition
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
