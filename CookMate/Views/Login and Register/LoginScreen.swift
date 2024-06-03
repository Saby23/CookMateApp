//
//  LoginScreen.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 06/02/24.
// 1. Have forgot password set up$

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                //header
                HeaderView()
                //Login form
                
                
                Form{
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    Section{
                        TextField("Email", text:$viewModel.email).autocapitalization(.none)
                            .autocorrectionDisabled()
                            
                        SecureField("Password", text: $viewModel.password).autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    
                    Button {
                        viewModel.login()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.green)
                            Text("Log In")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }

                }
                .padding(.top,50)
            
                //Create account
                VStack{
                    Text("New around here?")
                    NavigationLink("Create an account") {
                        RegistrationView()
                    }
                }.padding(.bottom, 10)
                
            }.padding(.top,90)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
