//
//  CreateRecipeView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 27/02/24.




// Need a close button for the recipe sheet
// 1. To save the recipe steps in the sheet
//      - I can have an array of steps here, that gets created separately that can be used for each recipe
//      - Then I can use that array to store and append data
//      - Each recipe needs Step name, side note, time
// 2. The recipe steps then create a list inside the create recipe section
// 3. Once I save the create recipe, it should save all the details within the recipe
// 4. The recipe list page also should show the recipes
// 5. The recipe list page should have the number of steps per recipe



// 9. On save, it should save in Firebase and then showup on the recipe screen
//10. If there is no data, then it should close, if there is data only then it should save


// 1. Create a model for recipe steps
// 2. Transfer all the data from recipe step to Create recipe view
// 3. Once the recipe is saved, save all the recipe steps for that recipe
// 4. Check for multiple recipe steps how to do that and if it saves in chronology
// 5. Then design the List cell
// 6. Show cell only when the submit is done on the recipe step


import SwiftUI

struct CreateRecipeView: View {
    @State private var recipeStepName : String = ""
    @Binding var newRecipeSaved : Bool
    
    @StateObject var viewModel = CreateRecipeViewModel()
   
    var stepNumber = 0
    
    var body: some View {
        
        NavigationView {
            VStack{
                Form {
                    Section{
                        TextField("Recipe Name", text: $viewModel.recipeName)
                    }
                    Section {
                        TextField("Ingredients", text: $viewModel.description, axis: .vertical)
                            .lineLimit(5...10)
                    }
                    
                    Section (header: Stepsheader()){
                        if !viewModel.steps.isEmpty {
                                    List {
                                        ForEach(Array(viewModel.steps.enumerated()), id: \.element.id) { index, step in
                                            RecipeStepListCellView(stepNumber: index + 1, step: step)
                                        }.onDelete { IndexSet in
                                            viewModel.steps.remove(atOffsets: IndexSet)
                                        }
                                    }
                        } else {
                            Text("No steps added yet")
                                .foregroundColor(.gray)
                        }
                        
                    }.textCase(nil)
                    
                    
                    Button {
                        if viewModel.canSave{
                            viewModel.save()
                            newRecipeSaved = false
                        }else {
                            viewModel.showAlert = true
                        }
                        
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .foregroundColor(.green)
                            .bold()
                            .frame(width: 300)
                    }.alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Error"), message: Text("Please fill in the recipe name"))
                    }
                    
                    
                    
                }.navigationTitle("Add recipe")
                
            }
            .sheet(isPresented: $viewModel.addNewStep) {
                RecipeStepSheet(newStep: viewModel).presentationDetents([.medium])
            }
        }
    }
    
    func AddStep(){
        self.viewModel.addNewStep.toggle()
    }
    
    private func Stepsheader() -> some View{
        HStack (spacing: 220){
            Text("Steps")
                .font(.system(size: 20))
                .foregroundColor(.black)
            Button {
                AddStep()
            } label: {
                Image(systemName: "plus.circle.fill")
            }
        }
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView(newRecipeSaved: .constant(true))
    }
}
