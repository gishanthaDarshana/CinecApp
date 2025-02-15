//
//  CinecAppApp.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import SwiftUI
import FirebaseCore

@main
struct CinecAppApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
