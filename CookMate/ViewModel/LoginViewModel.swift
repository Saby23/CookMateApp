//
//  LoginViewModel.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 03/03/24.
//
import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login(){
        guard validate() else {
            return
        }
        
        //Try to log the user in
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            errorMessage = "Please fill in all the fields"
            
            return false
        }
        
        //Email Validation
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid Email Address"
            return false
        }
        
        return true
    }
}
