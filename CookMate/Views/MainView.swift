//
//  MainView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 03/03/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            //signed in
            TabView {
                HomeScreen(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                TimerView()
                    .tabItem {
                        Label("Timer", systemImage: "clock.arrow.circlepath")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                
                CreateRecipeView(newRecipeSaved: $viewModel.showCreateRecipeScreen)
                    .tabItem {
                        Label("Create Recipe", systemImage: "fork.knife")
                    }
            }
        } else {
            LoginScreen()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
