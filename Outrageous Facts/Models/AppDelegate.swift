////
////  AppDelegate.swift
////  Outrageous Facts
////
////  Created by John Smith on 4/21/23.
////
//
//import Foundation
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
//    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//          // request for the permission
//          let center = UNUserNotificationCenter.current()
//          center.delegate = self
//          center.getNotificationSettings(completionHandler: { settings in
//            if settings.authorizationStatus == .authorized  {
//                print("permission granted")
//            }
//         })
//         return true
//    }
//    ...
//    ...
//}
