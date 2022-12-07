//
//  ChatWindow.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct ChatWindow: View {
    let chatId: String
    @State var openChatSettings = false
    @State var sendMessage = ""
    @StateObject var chatManager = ChatManager()
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "gear")
                    .font(.system(size: 28))
                    .foregroundColor(Color(uiColor: .darkGray))
                    .padding(.bottom, 16)
                    .padding(.trailing, 16)
                    .onTapGesture {
                        openChatSettings.toggle()
                    }
            }
            ScrollView{
                VStack{
                    ForEach(chatManager.messages, id: \.self) { message in
                        if message.senderId == LocalData.shared.id {
                            MessageItem(message: message)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 32)
                                    .foregroundColor(Color(UIColor.systemGreen)))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        } else {
                            MessageItem(message: message)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 32)
                                    .foregroundColor(Color(UIColor.systemGray4)))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .onAppear{
                chatManager.getMessages(chat: chatId)
            }
            HStack{
                customInputField(title: "Message", text: $sendMessage)
                Button {
                    chatManager.sendMessage(text: sendMessage, chat: chatId)
                    sendMessage = ""
                } label: {
                    Image(systemName: "paperplane.circle")
                        .foregroundColor(.green)
                        .font(.system(size: 48))
                }
            }
        }
        .overlay{
            if openChatSettings{
                UpdateChat(closeView: $openChatSettings, chatId: chatId)
            }
        }
    }
}
struct ChatWindow_Previews: PreviewProvider {
    static var previews: some View {
        ChatWindow(chatId: "A47F2B3A-E8CA-4E60-B781-34B5F91F866B")
    }
}
