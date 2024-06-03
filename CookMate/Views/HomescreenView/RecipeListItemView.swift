//
//  RecipeListItemView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 07/03/24.
//

import SwiftUI

struct RecipeListItemView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack{
            Image(systemName: "fork.knife.circle").resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)
            // Here I would like to have an array or icons that they users can select
            VStack (alignment: .leading){
                Text(recipe.recipeName)
                    .font(.system(size: 20))
                    .bold()
                Text(recipe.description)
                
            }
            
            //Need a button to go to a recipe page
        }
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItemView(recipe: MockData.recipeItemOne)
    }
}
