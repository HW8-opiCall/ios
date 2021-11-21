//
//  opiCallApp.swift
//  Shared
//
//  Created by Min Jae Lee on 2021-11-20.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct opiCallApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Connecting Firebase ...

class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        SessionService.signInAnonymously().sink{
            switch $0 {
            case .failure(let error):
                print(error)
            case .success:
                print("Login Success")
            }
        }
        return true
    }
}
