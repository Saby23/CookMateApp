//
//  RecipeStepSheet.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 01/03/24.
//

import SwiftUI

struct RecipeStepSheet: View {
    
    @ObservedObject var newStep: CreateRecipeViewModel
    
    @Environment(\.dismiss) var dismiss
    @State private var recipeStepName = ""
    @State private var minuteSelected = 0
    @State private var showTimer = false
    
    let minutesArray = Array(0...59)
   
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section{
                        TextField("Step Name", text: $recipeStepName)
                    }
                    Toggle(isOn: $showTimer.animation()) {
                        Text("Add timer")
                    }
                    if showTimer{
                        HStack{
                            Picker("Minutes", selection: $minuteSelected) {
                                ForEach(minutesArray,id:\.self){
                                    Text("\($0)")
                                        .foregroundColor(.green)
                                        .fontWeight(.bold)
                                }
                            }.pickerStyle(WheelPickerStyle())
                                .frame(height: 50)
                            Text("min")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            

                        }
                    }
                }
                Button {
                    
                    let step = RecipeStep(stepName: recipeStepName, stepDuration:(String(minuteSelected)), showTime: showTimer)
                    
                    newStep.steps.append(step)
                    
                    dismiss()
                    
                } label: {
                    Text("Done")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }.navigationTitle("Recipe Step")
        }
        
        
        
    }
}

struct RecipeStepSheet_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepSheet(newStep: CreateRecipeViewModel())
    }
}
