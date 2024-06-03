//
//  TimerViewModel.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 09/02/24.
//

import Foundation

class TimerViewModel: ObservableObject {
    
    private var startTimer = false
    private var totalTime = 0
    private var timeRemaining = 0
        
    func timerString (time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func timerRunning () {
        startTimer.toggle()
    }
    
    func refresh(){
        startTimer = false
        timeRemaining = totalTime
    }
    
}
