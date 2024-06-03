//
//  EditRecipeView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 07/05/24.
//
import SwiftUI

struct EditRecipeView: View {
    
    @StateObject var viewModel: EditRecipeViewModel
    @State var showStepEditor = false
    @State private var editStep : RecipeStep?
    @State private var editStepIndex: Int?
    
    
    init (userId: String,recipeId: String){
        self._viewModel = StateObject(wrappedValue:EditRecipeViewModel(userId: userId, recipeId: recipeId))
    }
    
    var body: some View {
        NavigationView {
            if let recipe = viewModel.recipe{
                VStack{
                    Form {
                        Section (header:sectionheader(sectionTitle: "Recipe Name")){
                            TextField("Recipe Name", text: $viewModel.recipeName).onAppear {
                                viewModel.recipeName = recipe.recipeName
                            }.font(.system(size: 20))
                            
                        }
                        Section (header:sectionheader(sectionTitle: "Ingredients")){
                            TextField("Recipe Name", text: $viewModel.description).onAppear {
                                viewModel.description = recipe.description
                            }
                        }
                        
                        Section (){
                           
                            ForEach(recipe.steps.indices, id: \.self) { index in
                                let step = recipe.steps[index]

                                RecipeStepListCellView(stepNumber: index + 1, step: step).onTapGesture {
                                    
                                    editStep = step
                                    editStepIndex = index
                                    showStepEditor.toggle()
                                }
                            }
                        }
                        
                    }
                    
                    Button {
                        viewModel.updateRecipe(recipe: recipe)
                    } label: {
                        Text("Save")
                    }
                    
                }.navigationTitle("Edit recipe")
                    .sheet(isPresented: $showStepEditor, content: {
                        if let index = editStepIndex {
                                                EditRecipeStepSheet(step: $viewModel.steps[index])
                                            }
                    })
                
            }
        }
    }
}



func sectionheader(sectionTitle: String) -> some View{
    Text(sectionTitle)
        .font(.system(size: 15))
        .foregroundColor(.gray)
        .textCase(nil)
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(userId:"T5sUB0rB6Rgvosignki3bSEFm6R2", recipeId:"2C43EB1D-8BD0-465F-A5B2-FE9ABD8D7646")
    }
}
