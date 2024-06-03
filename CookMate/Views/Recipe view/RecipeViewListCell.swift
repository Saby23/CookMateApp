//
//  RecipeViewListCell.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 22/04/24.
//

//1. Start and stop timer
//2. Load the recipe list into create recipe list screen
//3. Remove step description and renam recipe description to ingredients

import SwiftUI

struct RecipeViewListCell: View {
    
    var stepNumber: Int
    var step : RecipeStep
    
    @State var viewMore = false
    @State var playTimer = false
    @State private var stepDone = false
    
    @ObservedObject var tvModel = TimerViewModel()
    
    @State private var timeRemaining = 2*60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack (spacing: 10){
            ZStack{
                Circle()
                    .stroke(stepDone ? Color.gray : Color.green, lineWidth: 2)
                    .frame(width: 30).shadow(radius:1)
                
                Text("\(stepNumber)").font(.system(size: 15))
            }.onTapGesture {
                stepDone.toggle()
            }
            HStack (alignment: .bottom){
                Text(step.stepName)
                    .frame(width: 210, alignment: .leading)
                    .font(.system(size: 20))
                    .lineLimit(viewMore ? 15 : 2).onTapGesture {
                        viewMore.toggle()
                    }
            }
            Spacer()
            if step.showTime{
                VStack(spacing:2){
                    if playTimer{
                        VStack{
                            HStack{
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                    .foregroundColor(.gray)
                            }
                            Text(tvModel.timerString(time: timeRemaining)).onReceive(timer) { time in
                                if timeRemaining > 0 && playTimer && !stepDone {
                                    print(timeRemaining)
                                    timeRemaining-=1
                                }
                            }
                        }
                    } else{
                        Image(systemName: "play.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(stepDone ? .gray : .green)
                        Text("\(step.stepDuration) min")
                            .font(.system(size: 18))
                    }
                }.allowsHitTesting(stepDone ? false : true)
                    .onTapGesture {
                        playTimer.toggle()
                        timeRemaining = (Int(step.stepDuration)!)*60
                    }
            }
        }.padding(10)
            .frame(width: 350)
            .buttonBorderShape(.roundedRectangle)
            .strikethrough(stepDone ? true : false)
            .foregroundColor(stepDone ? .gray : .black)
    }
    
}

struct RecipeViewListCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeViewListCell(stepNumber: 1, step: RecipeStep(stepName: "Boil Rice in bowl, that is kept on the gas and has that gas is turned on", stepDuration: "2", showTime: true))
    }
}
