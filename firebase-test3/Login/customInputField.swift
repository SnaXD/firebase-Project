//
//  customInputField.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct customInputField: View {
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
                TextField("", text: $text, axis: .vertical)
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

struct customInputField_Previews: PreviewProvider {
    static var previews: some View {
        customInputField_PreviewsWithBinding()
    }
}

fileprivate struct customInputField_PreviewsWithBinding: View {
    @State var text = "Hi hows your day been?"
    var body: some View {
        customInputField(title: "Note", text: $text)
    }
}
