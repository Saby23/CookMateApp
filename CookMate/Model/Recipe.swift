//
//  Recipe.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 02/03/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id : String
    var recipeName: String
    var description: String
    var steps: [RecipeStep]
    let createdDate: TimeInterval
    
    var isDone: Bool
   
    var totalSteps: Int {
        steps.count
    }
    var totalDuration: Int {
        var total = 0
        for step in steps {
            total += Int(step.stepDuration) ?? 0
        }
        return total
//        steps.reduce(0) { total, step in
//                    total + (Int(step.stepDuration) ?? 0)
//                }
    }
    
    mutating func isDone(_ state: Bool){
        isDone = state
    }
}

struct RecipeStep: Identifiable, Hashable, Codable {
    let id : UUID
    var stepName: String
    var stepDuration: String
    var showTime: Bool
    
    // Provide a custom init to automatically generate a UUID if not provided
        init(id: UUID = UUID(), stepName: String, stepDuration: String, showTime: Bool) {
            self.id = id
            self.stepName = stepName
            self.stepDuration = stepDuration
            self.showTime = showTime
        } 
}


struct MockData {
    static let recipeItemOne = Recipe(id: "1", recipeName: "Tea", description: "Recipe for a herbal tea for cold",
                                        steps: [
                                          RecipeStep(stepName: "Boil water", stepDuration: "10", showTime: true),
                                          RecipeStep(stepName: "Add herbs", stepDuration: "5", showTime: true)
                                        ],
                                        createdDate: Date().timeIntervalSince1970, isDone: false)
    
}
