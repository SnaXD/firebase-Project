//
//  LocalData.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

class LocalData: ObservableObject {
    private init(){}
    
    static let shared = LocalData()
    @AppStorage("id") var id: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("password") var password: String = ""
    @Published var chatIds: [String] = []
    @AppStorage("name") var usersName: String = ""
}
extension LocalData {
    func assignUser(user: User){
        self.id = user.id
        self.email = user.email
        self.password = user.password
        self.chatIds = chatIds
        self.usersName = user.name
    }
    
    func signOut(){
        self.id = ""
        self.email = ""
        self.password = ""
        self.chatIds = []
        self.usersName = ""
    }
}
