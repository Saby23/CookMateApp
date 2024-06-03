//
//  RecipeViewModel.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 10/04/24.
//
import FirebaseFirestore
import Foundation


class RecipeViewModel: ObservableObject{
    @Published var showCreateRecipeScreen = false
    @Published var recipe: Recipe?
    private var db = Firestore.firestore()
    
    
   @Published var userId: String = ""
   @Published var recipeId: String = ""
    
    init(userId: String, recipeId: String){
        self.userId = userId
        self.recipeId = recipeId
        fetchRecipe()
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
    
}
