//
//  ChatManager.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    let db = Firestore.firestore()
    
    init(){
        getChats()
    }
    
    func getChats() {
        db.collection("users").whereField(UserFields.id.rawValue, isEqualTo: "\(LocalData.shared.id)")
            .addSnapshotListener { querySnapshot, error in
                guard let document = querySnapshot?.documents.first else {
                    print("\(String(describing: error))")
                    return
                }
                do {
                    let decoded: User = try document.data(as: User.self)
                    LocalData.shared.chatIds = decoded.chats
                } catch {
                    print("LocalUserid == nil \(error)")
                }
            }
    }
    
    func createNewChat() {
        let id = "\(UUID())"
        let firstMessageId = "\(UUID())"
        db.collection("chats").document(id).setData(["id": id])
        db.collection("chats").document(id).collection("messages").addDocument(data: [
            "\(MessageField.id.rawValue)": firstMessageId,
            "\(MessageField.message.rawValue)": "\(LocalData.shared.email) started a new chat",
            "\(MessageField.senderId.rawValue)": "\(UUID())",
            "\(MessageField.timestamp.rawValue)": Date(),
            "\(MessageField.senderName)": "System"]) { error in
                if let error = error {
                    print("Error writing message document: \(error)")
                }
            }
        addChatToUser(chatId: id, userEmail: LocalData.shared.email)
    }
    
    func addChatToUser(chatId: String, userEmail: String){
        var users: [User] = []
        db.collection("users")
            .whereField(UserFields.email.rawValue, isEqualTo: userEmail)
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
                if let usersId = users.first?.id {
                    self.db.collection("users").document("\(String(describing: usersId))").updateData([
                        "\(UserFields.chats.rawValue)": FieldValue.arrayUnion([chatId])
                    ])
                }
            })
    }
    
    func getMessages(chat: String) {
        db.collection("chats")
            .document(chat)
            .collection("messages")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("\(String(describing: error))")
                    return
                }
                self.messages = documents.compactMap { document -> Message? in
                    do {
                        return try document.data(as: Message.self)
                    } catch {
                        print(error)
                        return nil
                    }
                }
                self.messages.sort { $0.timestamp < $1.timestamp}
            }
    }
    
    func sendMessage(text: String, chat: String) {
        if text != ""{
            do {
                let newMessage = Message(id: "\(UUID())", message: text, senderId: LocalData.shared.id, senderName: LocalData.shared.usersName, timestamp: Date())
                try db.collection("chats")
                    .document(chat)
                    .collection("messages")
                    .document().setData(from: newMessage)
            } catch {
                print("\(error)")
            }
        }
    }
}
