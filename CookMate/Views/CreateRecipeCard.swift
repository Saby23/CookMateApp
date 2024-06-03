//
//  CreateRecipeCard.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 04/03/24.
//

import SwiftUI

struct CreateRecipeCard: View {
    var body: some View {
        NavigationView {
            VStack (spacing:40){
                Text("Welcome Chef!\n Create a new recope here")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .opacity(0.7)
                
                NavigationLink {
//                    CreateRecipeView()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black)
                }
                
            }.frame(width: 350, height: 250)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 25).stroke(.green, lineWidth:3)
                })
                
        }
        
    }
}

struct CreateRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeCard()
    }
}
