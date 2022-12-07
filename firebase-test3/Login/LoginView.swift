//
//  LoginView.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @State var email: String = ""
    @State var password: String = ""
    @State var openRegisterSheet: Bool = false
    @StateObject var vm = LoginVM()
    let localData = LocalData.shared
    var body: some View {
        VStack{
            Text("Login")
            customInputField(title: "Email", text: $email)
            customSecureInputField(title: "Password", text: $password)
            Button {
                openRegisterSheet.toggle()
            } label: {
                Text("Register")
                    .font(.system(size: 12))
                    .padding(8)
                    .padding(.horizontal, 8)
                    .foregroundColor(.orange)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(vm.errorMessage)
            Button {
                vm.login(email: email, password: password, dismiss: dismiss)
            } label: {
                Text("Login")
            }
            .foregroundColor(.white)
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.green))
        }
        .interactiveDismissDisabled(true)
        .sheet(isPresented: $openRegisterSheet) {
            RegisterView()
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
