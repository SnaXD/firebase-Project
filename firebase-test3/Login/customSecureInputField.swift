//
//  customSecureInputField.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct customSecureInputField: View {
    let title: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title.uppercased())
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(alignment: .leading)
            Divider()
                .padding(.vertical, 8)
            SecureField("", text: $text)
                .background{
                    HStack{
                        Spacer()
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
        }
        .padding()
        .background(.white)
        .overlay{
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 0)
        }
    }
}

struct customSecureInputField_Previews: PreviewProvider {
    static var previews: some View {
        customSecureInputField_PreviewsWithBinding()
    }
}
fileprivate struct customSecureInputField_PreviewsWithBinding: View {
    @State var text = ""
    var body: some View {
        customSecureInputField(title: "Note", text: $text)
    }
}
