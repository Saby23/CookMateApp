//
//  HeaderView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 02/03/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            Image(systemName: "fork.knife.circle.fill").resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            Text("CookMate")
                .font(.system(.largeTitle))
                .fontWeight(.bold)
            Text("Your personal cooking assistant")
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
