//
//  RecipeView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 27/02/24.
//
//1. Have checkboxes for each step
//2. create the checkboxes in a shape, so that it can be differentiated
//3. Mark steps as done when tapped on the checkbox
// 4. Tap to start the timer, tap to stop and double tab to restart the timer, show a restart button next to it
//5. have an add groceries list there (in the groceries page section show the number that needs to be bought)


//- Handle Null values
import FirebaseFirestoreSwift
import SwiftUI

struct RecipeView: View {
    
    @StateObject private var viewModel: RecipeViewModel
    
    
    init (userId: String,recipeId: String){
        self._viewModel = StateObject(wrappedValue: RecipeViewModel(userId: userId, recipeId: recipeId))
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                if let recipe = viewModel.recipe {
                    HStack{
                        Text(recipe.recipeName)
                            .font(.largeTitle)
                            .textCase(nil)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                        
                        NavigationLink {
                            EditRecipeView(userId: viewModel.userId, recipeId: recipe.id)
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .fontWeight(.bold)
                                .frame(width: 20, height: 20)
                        }.padding(20)

                        
                    }
                    List {
                        Section(header: HStack(){
                            Text("Total Time: \(recipe.totalDuration) min")
                                .font(.body)
                                .textCase(nil)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Total Steps: \(recipe.totalSteps)")
                                .font(.body)
                                .textCase(nil)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }) {
                            ForEach(recipe.steps.indices, id: \.self) { index in
                                let step = recipe.steps[index]
                                RecipeViewListCell(stepNumber: index + 1, step: step)
                                    .listRowSeparatorTint(Color.gray)
                                    .listRowSeparator(.visible, edges: .bottom)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    
                    Button("Close") {
                        // Action to close or dismiss the view
                    }
                    .padding()
                } else {
                    Text("Loading recipe...")
                }
            }
            .onAppear(perform: viewModel.fetchRecipe)
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(userId:"T5sUB0rB6Rgvosignki3bSEFm6R2", recipeId:"2C43EB1D-8BD0-465F-A5B2-FE9ABD8D7646")
    }
}
