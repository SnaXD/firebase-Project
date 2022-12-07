//
//  Circle.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI

struct PlusCircle: View {
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                    .padding(16)
                    .shadow(radius: 1)
            }
        }
    }
}
