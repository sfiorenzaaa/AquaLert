//
//  shannonfinaltestSEfixApp.swift
//  AquaAlert
//
//  Created by Macbook on 05/06/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct shannonfinaltestSEfixApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authController = AuthController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
        }
    }
}
