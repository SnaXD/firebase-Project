//
//  firebase_test3App.swift
//  firebase-test3
//
//  Created by Jonathan T. Nielsen on 06/12/2022.
//

import SwiftUI
import Firebase

@main
struct firebase_test3App: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            Frontpage()
        }
    }
}
