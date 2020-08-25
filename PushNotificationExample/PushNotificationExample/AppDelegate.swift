//
//  AppDelegate.swift
//  PushNotificationExample
//
//  Created by omrobbie on 25/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        notificationConfigure(application: application)

        InstanceID.instanceID().instanceID(handler: { (result, _) in
            if let token = result?.token {
                print("Token", token)
            }
        })
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func notificationConfigure(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self

        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption) { (_, _) in

        }

        application.registerForRemoteNotifications()
    }
}
