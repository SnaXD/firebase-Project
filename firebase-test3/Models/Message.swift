//
//  Message.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import Foundation

struct Message: Identifiable, Codable, Hashable {
    var id: String
    var message: String
    var senderId: String
    var senderName: String
    var timestamp: Date
}

enum MessageField: String {
    case id, message, senderId, senderName, timestamp
}
