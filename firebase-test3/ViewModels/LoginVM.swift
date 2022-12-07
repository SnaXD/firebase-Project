//
//  LoginVM.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import BCrypt

class LoginVM: ObservableObject {
    let db = Firestore.firestore()
    var errorMessage = ""
    
    func registerUser(email: String, password: String, name: String){
        //Avoid a user accidently make 2 accounts - Does not work only if your connection are very fast
        _ = findUsersWithEmail(email: email){ users in
            if users.count < 0 {
                self.errorMessage = "Email already in use"
                return
            }
            do {
                let encodedPassword = try BCrypt.Hash(password, salt: BCrypt.Salt())
                let id = "\(UUID())"
                self.registerFunction(email: email, password: encodedPassword, id: id, name: name)
                LocalData.shared.assignUser(user: User(id: "\(id)", email: email, password: encodedPassword, chats: [], name: name))
                self.errorMessage = ""
                return
            } catch {
                print("Error in password \(error)")
                self.errorMessage = "An error was found in your password"
                return
            }
        }
    }
    
    private func registerFunction(email: String, password: String, id: String, name: String){
        //Write data
        db.collection("users").document("\(id)").setData([
            "id": id,
            "email": email,
            "password": password,
            "chats": [],
            "name": name]) { error in
                if let error = error {
                    print("Error writing Login document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            }
    }
    
    func login(email: String, password: String, dismiss: DismissAction) {
         _ = findUsersWithEmail(email: email) { users in
            if users.count == 0 {
                self.errorMessage = "No user found with this email"
                return
            }
            for user in users {
                let encryptedPassword = BCrypt.Check(password, hashed: user.password)
                if encryptedPassword {
                    LocalData.shared.assignUser(user: user)
                    self.errorMessage = ""
                    break
                }
            }
            self.errorMessage = "Wrong email or password"
            if LocalData.shared.id != "" {
                dismiss()
            }
        }
    }
    
    func findUsersWithEmail(email: String, completion: @escaping ([User]) -> Void) -> [User]{
        var users: [User] = []
        //Query
        db.collection("users")
            .whereField(UserFields.email.rawValue, isEqualTo: email)
            .getDocuments(completion: { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("\(String(describing: error))")
                    return
                }
                users = documents.compactMap { document -> User? in
                    do {
                        return try document.data(as: User.self)
                    } catch {
                        print(error)
                        return nil
                    }
                }
                completion(users)
            })
        return users
    }
}
