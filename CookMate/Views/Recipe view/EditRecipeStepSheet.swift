//
//  EditRecipeStepSheet.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 21/05/24.
//


import SwiftUI

struct EditRecipeStepSheet: View {
    
    
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var step: RecipeStep
    @State private var recipeStepName = "Test"
    @State private var minuteSelected = 0
    @State private var showTimer = false
    
    
    let minutesArray = Array(0...59)
   
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section{
                        TextField("Step Name", text: $recipeStepName, axis: .vertical).lineLimit(3...5)
                    }
                    Toggle(isOn: $showTimer.animation()) {
                        Text("Add timer")
                    }
                    if showTimer{
                        HStack{
                            Picker("Minutes", selection: $minuteSelected) {
                                ForEach(minutesArray,id:\.self){minute in
                                    Text("\(minute)")
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
                    
                    step = RecipeStep(stepName: recipeStepName, stepDuration:(String(minuteSelected)), showTime: showTimer)
                    
                    dismiss()
                    
                } label: {
                    Text("Done")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }.navigationTitle("Recipe Step")
        }.onAppear{
            
                recipeStepName = step.stepName
                minuteSelected = Int(step.stepDuration) ?? 0
                showTimer = step.showTime
            
        }
        
        
        
    }
}

struct EditRecipeStepSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeStepSheet(step: .constant(RecipeStep(stepName: "test", stepDuration: "3", showTime: true)))
    }
}

