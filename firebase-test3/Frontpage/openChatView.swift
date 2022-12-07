//
//  openChatView.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct openChatView: View {
    var name: String
    var image: UIImage?
    var body: some View {
        HStack{
            Image(uiImage: image ?? UIImage(named: "Placeholder")!)
                .resizable()
                .frame(width: 75, height: 75, alignment: .leading)
                .clipShape(Circle())
                .shadow(radius: 3)
            
                Text(name)
                    .fontWeight(.medium)
                    .font(.system(size: 30))
                    .minimumScaleFactor(0.01)
                    .padding(.leading, 16)
            Spacer()
        }
        .padding(16)
        .background{
            RoundedRectangle(cornerRadius: 28)
                .foregroundColor(Color(uiColor: .systemGray4))
                .shadow(radius: 1)
        }
        .frame(height: 100)
        .padding(16)
        
    }
}

struct openChat_Previews: PreviewProvider {
    static var previews: some View {
        openChatView(name: "Jens Jensen")
    }
}
