//
//  User.swift
//  CookMate
//
//  Created by Sabyasachi Sahu on 02/03/24.
//

import Foundation

struct  User: Codable {
    let id: String
    let name : String
    let email: String
    let joined: TimeInterval
}
