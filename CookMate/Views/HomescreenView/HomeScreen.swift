//
//  HomeScreen.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 06/02/24.
//

//Color palette: https://colorhunt.co/palette/00425a1f8a70bfdb38fc7300

// 4. The recipes should be scrollable

// 5. In future have a search functionality as well
//1.Create a model where the different names of the recipe gets added
// 2. Load a few of them here
// 3. Have a option to delete/edit the recipe
// 4. Navigate to a different view where you show the recipe

import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

struct HomeScreen: View {
    
    @StateObject var viewModel :  HomeScreenViewModel
    
    @FirestoreQuery(collectionPath: "") var recipes : [Recipe]
    
    private let userId : String
     
    init (userId: String){
        self.userId = userId

        self._recipes = FirestoreQuery(
            collectionPath: "users/\(userId)/recipe"
        )
        self._viewModel = StateObject(wrappedValue: HomeScreenViewModel(userId: userId))
    }
    
    var body: some View {
        
        NavigationView {
            VStack{
                //header section
                HStack {
                    Text("Recipe List")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        viewModel.showCreateRecipeScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }.padding(20)
                    
                }.padding(.horizontal)
                
                List(recipes){ recipe in
                    
                    NavigationLink(destination: RecipeView(userId:userId,recipeId: recipe.id)){
                        RecipeListItemView(recipe: recipe)
                            .swipeActions {
                                Button {
                                    viewModel.deleteRecipe(id: recipe.id)
                                } label: {
                                    Text("Delete")
                                }.tint(.red)

                            }
                    }
                    
                    
                }
            }.sheet(isPresented: $viewModel.showCreateRecipeScreen) {
                CreateRecipeView(newRecipeSaved: $viewModel.showCreateRecipeScreen)
            }
        }
    }
}
    
    struct HomeScreen_Previews: PreviewProvider {
        static var previews: some View {
            HomeScreen(userId: "T5sUB0rB6Rgvosignki3bSEFm6R2")
        }
    }
    
    
   

