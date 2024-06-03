//
//  HomeScreenViewModel.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 04/03/24.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class HomeScreenViewModel : ObservableObject {
    @Published var showCreateRecipeScreen = false
    @Published var showRecipeView = false
    
    @Published var recipes = [Recipe]()
    
    @Published var userId: String
    
    init(userId: String){
        self.userId = userId
    }
    
    func fetchRecipe(id:String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("recipe")
            .getDocuments { snapshot, error in
                //check for errors
                
                if error == nil {
                    if let snapshot = snapshot {
                        self.recipes = snapshot.documents.map { recipe in
                            return Recipe(
                                id: recipe.documentID,
                                recipeName: recipe["recipeName"] as! String,
                                description: recipe["description"] as! String,
                                steps: recipe["steps"] as! [RecipeStep] ,
                                createdDate: recipe["createdDate"] as! TimeInterval,
                                isDone: (recipe["isDone"] != nil))
                        }
                    }
                    
                } else {
                    //Handle errors
                }
            }
        
    }
    
    func deleteRecipe(id:String){
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("recipe")
            .document(id)
            .delete()
    }
}
