//
//  RecipeStepListCellView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 02/04/24.
//

import SwiftUI

struct RecipeStepListCellView: View {
    
    var stepNumber: Int
    var step : RecipeStep
  
    
    var body: some View {
        HStack (spacing: 10){
            ZStack{
                Circle()
                    .stroke(Color.green, lineWidth: 5).frame(width: 30).shadow(radius:1)
                Text("\(stepNumber)").font(.system(size: 15))
            }
            VStack (alignment: .leading){
                Text(step.stepName)
                    .frame(width: 210, alignment: .leading)
                    .font(.system(size: 18))
                    .lineLimit(0...3)
            }
            Spacer()
            if step.showTime{
                ZStack{
                    Circle()
                        .stroke(Color.gray, lineWidth: 1).frame(width: 40)
                    VStack{
                        Text("\(step.stepDuration)")
                        Text("min").font(.system(size: 10))
                    }
                }
            }
        }.padding(5)
        .frame(width: 350)
        
    }
    
}

struct RecipeStepListCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepListCellView(stepNumber: 1, step: RecipeStep(stepName: "Boil Rice", stepDuration: "2", showTime: true))
    }
}
