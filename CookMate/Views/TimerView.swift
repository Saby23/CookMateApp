//
//  TimerView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 06/02/24.
//

// What I need to do:
// - First Create a timer that reduces every second-> Done
// - The text also should update every second and should be displayed as minutes and seconds. It should update as a timer -> Done
// - Then have a start and stop functionality -> Done
// Then allow to set timer functionality -> done
//- Then reduce the circle as the timer reduces -> Done
//- Change the color of the button when pressed
//- handle when there is zero minutes


import SwiftUI

struct TimerView: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isTimerRunning = false
    @State private var showTimePicker = false
    @State private var minuteSelected = 2
    @State private var secondSelected = 60
    @State private var timeRemaining = 2*60
    @State private var  totalTime = 2*60
    @State private var startButtonPressed = false
    @State private var stopButtonPressed = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let minutesArray = Array(0...59)
    let secondsArray = Array(0...59)
    
    //all this can be moved to a viewModel, it would become timerViewModel()
    
    var body: some View {
        
        VStack {
            Text("Set timer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top,10)
            
            Spacer()
            
            ZStack {
                
                VStack{
                    
                    Button {
                        showTimePicker = true
                    } label: {
                        Text(timeString(time: timeRemaining)).onReceive(timer){
                            time in
                            if timeRemaining > 0 && isTimerRunning {
                                timeRemaining-=1
                                progress = CGFloat(timeRemaining)/CGFloat(totalTime)
                            }
                        }
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .sheet(isPresented: $showTimePicker) {
                            VStack{
                                HStack{
                                    Picker("Minutes", selection: $minuteSelected) {
                                        ForEach(minutesArray,id:\.self){
                                            Text("\($0)")
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                        .frame(width: 100, height: 150)
                                        .compositingGroup()
                                        .clipped()
                                    
                                    Text("min")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Picker("Seconds", selection: $secondSelected) {
                                        ForEach(secondsArray,id:\.self){
                                            Text("\($0)")
                                        }
                                    }.pickerStyle(WheelPickerStyle())
                                        .frame(width: 100, height: 150)
                                        .compositingGroup()
                                        .clipped()
                                    
                                    Text("sec")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                
                                Button {
                                    showTimePicker = false
                                    
                                    timeRemaining = minuteSelected*secondSelected
                                    totalTime = minuteSelected*secondSelected
                                } label: {
                                    Text("Done")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                }
                                
                            }
                        }
                        
                    }
                    
                    Button {
                        reset()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .frame(width: 30, height: 35)
                            .foregroundColor(.black)
                    }.padding(.top,30)
                }.padding(.top,40)
                
                
                
                //Backgroud Circle
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .frame(width: 300)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    //Foreground circle
                    
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(style:StrokeStyle(lineWidth: 15, lineCap: .round))
                        .frame(width: 300)
                        .foregroundColor(Color.green)
                        .rotationEffect(Angle(degrees: 270))
                }
                              
                
            }
            
            
            Spacer()
            HStack(spacing: 80){
                Button {
                    start()
                } label: {
                    PlaypauseButton(buttonIcon: startButtonPressed ? "pause.fill" : "play.fill", offset: startButtonPressed ? 0 : 3, isSelected: $startButtonPressed)
                }
                   
//                Button {
//                    stop()
//                } label: {
//                    PlaypauseButton(buttonIcon: "arrow.clockwise", offset: 0, isSelected: $stopButtonPressed)
//                }
            }
            
            
        }
    }
    func timeString(time: Int) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func start(){
//        isTimerRunning = true
        self.isTimerRunning.toggle()
        self.startButtonPressed.toggle()
        stopButtonPressed = false
        }
    
    func stop(){
        isTimerRunning = false
        self.stopButtonPressed.toggle()
        startButtonPressed = false
    }
    
    func reset(){
        timeRemaining = totalTime
        isTimerRunning = false
        progress = 0.0
        stopButtonPressed = false
        startButtonPressed = false
    }
}




struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

struct ButtonPressedStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
            .foregroundColor(configuration.isPressed ? Color.green : Color.gray)
    }
}
