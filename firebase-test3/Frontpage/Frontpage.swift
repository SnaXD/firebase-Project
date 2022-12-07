//
//  Frontpage.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct Frontpage: View {
    let vm = ChatManager()
    @StateObject var localData = LocalData.shared
    @State var openLoginSheet = false
    @State var showCreateNewChat = false
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                    Text("Chats")
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                        .padding(.bottom, 32)
                        
                        HStack(spacing: 0){
                            Spacer()
                        
                            Button {
                                localData.signOut()
                                openLoginSheet.toggle()
                            } label: {
                                Text("Signout")
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .foregroundColor(.red))
                            }
                        }
                    }
                        
                    ScrollView{
                        ForEach(localData.chatIds, id: \.self){ chat in
                            NavigationLink(destination: ChatWindow(chatId: chat)){ openChatView(name: chat)
                            }
                        }
                    }
                    HStack{
                        Spacer()
                    }
                    .onAppear{
                        if LocalData.shared.id == "" {
                            openLoginSheet.toggle()
                        }
                    }
                    .sheet(isPresented: $openLoginSheet, onDismiss: {
                        vm.getChats()
                    }) {
                        LoginView()
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color("Background"))
                PlusCircle()
                    .onTapGesture {
                        ChatManager().createNewChat()
                    }
            }
        }
    }
}

struct Frontpage_Previews: PreviewProvider {
    static var previews: some View {
        Frontpage()
    }
}
