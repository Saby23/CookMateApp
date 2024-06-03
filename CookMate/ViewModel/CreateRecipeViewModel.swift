//
//  CreateRecipeViewModel.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 05/03/24.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class CreateRecipeViewModel: ObservableObject {
    
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
    
    
    init(){}
    
    func addStep(){
        let newRecipeStep = RecipeStep(stepName: recipeStepName,
                                       stepDuration: recipeStepDuration,
                                       showTime: showTime)
        self.steps.append(newRecipeStep)
    }
    

    func save (){
        guard canSave else {
            return
        }
        //Get current userId -> This is to the check the user is present
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        //Create a model
        let newId = UUID().uuidString
        
        let newRecipe = Recipe(id: newId,
                               recipeName: recipeName,
                               description: description,
                               steps: steps,
                               createdDate: Date().timeIntervalSince1970,
                               isDone: false)
        
     
        
        //Save the model to the data base
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("recipe")
            .document(newId)
            .setData(newRecipe.asDictionary())
        
        //If the recipeSteps are present, then add it to the newrecipeID, it would add steps as per the stepID
        
    }
    
    
    
    var canSave: Bool{
        guard !recipeName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}
