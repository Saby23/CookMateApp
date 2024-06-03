//
//  PlaypauseButton.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 06/02/24.
//

import SwiftUI

struct PlaypauseButton: View {
    var buttonIcon : String
    var offset: CGFloat
    @Binding var isSelected : Bool
    
    var body: some View {
    
        ZStack{
            Circle().foregroundColor(.green)
                .frame(width: 80)
                .opacity(isSelected ? 0.9 : 0.5)
            Image(systemName: buttonIcon)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.black).offset(x: offset)
        }
    }
}

struct PlaypauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaypauseButton(buttonIcon: "play.fill", offset: 3, isSelected: .constant(false))
    }
}
