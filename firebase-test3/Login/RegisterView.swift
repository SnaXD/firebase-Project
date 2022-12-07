//
//  RegisterView.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    var vm = LoginVM()
    let localData = LocalData.shared
    var body: some View {
        ZStack{
            VStack(alignment: .trailing){
                HStack{
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                Spacer()
            }
            VStack{
                Text("Register")
                customInputField(title: "What do you wanna be called", text: $name)
                customInputField(title: "Email", text: $email)
                customSecureInputField(title: "Password", text: $password)
                
                Text(vm.errorMessage)
                Button {
                    vm.registerUser(email: email, password: password, name: name)
                    dismiss()
                } label: {
                    Text("Register")
                }
                .foregroundColor(.white)
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.orange))
            }

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
