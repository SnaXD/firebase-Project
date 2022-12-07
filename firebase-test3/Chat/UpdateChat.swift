//
//  createNewView.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct UpdateChat: View {
    @Binding var closeView: Bool
    @State var inviteEmail = ""
    var chatId: String
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 250)
                .foregroundColor(Color(uiColor: .systemGray5))
                .shadow(radius: 2)
                .overlay{
                    VStack{
                HStack{
                    Text("Invite to chat")
                        .font(.system(size: 26))
                        .fontWeight(.light)
                        .padding(.leading, 16)
                    Spacer()
                    Image(systemName: "x.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.blue)
                        .padding()
                        .onTapGesture {
                            closeView.toggle()
                        }
                }
                customInputField(title: "Other participants Email", text: $inviteEmail)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                Button {
                    ChatManager().addChatToUser(chatId: chatId, userEmail: inviteEmail)
                    closeView.toggle()
                } label: {
                    Text("Invite")
                        .padding(16)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.green))
                        .shadow(radius: 1)
                }
                .padding(.bottom, 16)

            }
        }
                .padding(16)
        }
    }
}

struct createNewChat_Previews: PreviewProvider {
    static var previews: some View {
        createNewChat_PreviewsWithBinding()
    }
}

struct createNewChat_PreviewsWithBinding: View {
    @State var closeView = false
    var body: some View {
        UpdateChat(closeView: $closeView, chatId: "aaaa")
    }
}
