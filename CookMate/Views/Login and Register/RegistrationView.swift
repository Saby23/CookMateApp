//
//  RegistrationView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 02/03/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                //header
                HeaderView()
                //Login form
                Form{
                    Section{
                        TextField("Username", text:$viewModel.name)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        TextField("Email", text:$viewModel.email)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        SecureField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    
                    Button {
                        viewModel.register()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.green)
                            Text("Register")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }

                }
                .padding(.top,50)
            }.padding(.top,90)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
