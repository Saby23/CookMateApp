//
//  EditRecipeViewModel.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 06/05/24.
//
import FirebaseFirestore
import SwiftUI

class EditRecipeViewModel: ObservableObject {
    private var userId: String
    private var recipeId: String
    @Published var recipe: Recipe?
    //Recipe
    @Published var recipeName = ""
    @Published var description = ""
    @Published var stepDuration = ""
    @Published var addNewStep = false
    @Published var showAlert = false
    @Published var totalSteps = 0
    @Published var totalDuration = 0
    
    
    //RecipeStep
    @Published var steps:[RecipeStep] = []// Here I am mentionning that this is an array of steps
    @Published var recipeStepName = ""
    @Published var recipeStepDuration = ""
    @Published var showTime = true
    
    
    private var db = Firestore.firestore()

    init(userId: String,recipeId: String) {
        self.userId = userId
        self.recipeId = recipeId
        fetchRecipe()
    }
    
    func addStep(){
        let newRecipeStep = RecipeStep(stepName: recipeStepName,
                                       stepDuration: recipeStepDuration,
                                       showTime: showTime)
        self.steps.append(newRecipeStep)
    }

    func fetchRecipe() {
        let recipeRef = db.collection("users").document(userId).collection("recipe").document(recipeId)
        
        recipeRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.recipe = try document.data(as: Recipe.self)
                } catch {
                    print("Error decoding recipe: \(error)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateRecipe (recipe: Recipe) {
            
        var updatedRecipe = recipe
        
        updatedRecipe.recipeName = recipeName
        updatedRecipe.description = description
        
            let docRef = db.collection("users").document(userId).collection("recipe").document(recipeId)
            do {
              try docRef.setData(from: updatedRecipe)
            }
            catch {
              print(error)
            }
          
    }
}
