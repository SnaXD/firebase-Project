//
//  MessageItem.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct MessageItem: View {
    @State var message: Message
    @State var showSendTime: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text(message.senderName)
                .font(.system(size: 16))
                .fontWeight(.light)
                .foregroundColor(.gray)
            HStack{
                Text(message.message)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.5)){
                            showSendTime.toggle()
                        }
                    }
            }
            if showSendTime {
                Text(message.timestamp.formatted(.dateTime.day().month().hour().minute()))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem(message: Message(id: "aaa", message: "VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE VERY LONG MESSAGE ", senderId: "", senderName: "Steve", timestamp: Date()))
    }
}
