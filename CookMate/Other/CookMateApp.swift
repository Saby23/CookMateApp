//
//  CookMateApp.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 06/02/24.
//1.Firestore security rules need to be updated
//2. Change the way the data is stored in firebase
import Firebase
import SwiftUI

@main
struct CookMateApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
