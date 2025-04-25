//
//  COBSCComp212p_041App.swift
//  COBSCComp212p-041
//
//  Created by Nilakshi Anuradha on 2024-10-27.
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
struct COBSCComp212p_041App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("current_status") var status:Bool = false
    var body: some Scene {
        WindowGroup {
            NavigationView{
                Group{
                    if status{
                        BottomTabBarView()
                    } else{
                        LoginView()
                    }
                }
            }
        }
    }
}
