//
//  ProfileView.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 11/03/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfilViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
//
                if let user = viewModel.user {
                    // Avatar image
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.green)
                        .frame(width: 125, height: 125)
                        .padding()
                    //Info- Name of the Chef, number of recipe
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Name:")
                            Text(user.name)
                        }
                        HStack{
                            Text("Email:")
                            Text(user.email)
                        }
                        HStack{
                            Text("Cooking since:")
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: .shortened))")
                        }
                    }
                    //signout
                    Button {
                        viewModel.logout()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(.white)
                            .frame(maxWidth: 100)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                } else {
                    Text("Loading profile...")
                }

                
            }.navigationTitle("Profile")
        }.onAppear{
            viewModel.fetchUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
