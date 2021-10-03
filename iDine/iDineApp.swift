//
//  DrDogSwiftUiApp.swift
//  DrDogSwiftUi
//
//  Created by michael dang on 10/2/21.
//

import SwiftUI

@main
struct iDineApp: App {
    
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
