//
//  User.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var email: String
    var password: String
    var chats: [String]
    var name: String
}

enum UserFields: String {
    case id, email, password, chats, name
}
