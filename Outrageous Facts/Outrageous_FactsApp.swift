//
//  Outrageous_FactsApp.swift
//  Outrageous Facts
//
//  Created by John Smith on 12/25/22.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds
import UserNotifications


@main
struct Outrageous_FactsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    //    //Use init() in place of ApplicationDidFinishLaunchWithOptions in App Delegate
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FactView.shared
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        if ((launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification]) != nil) {
            NotificationHandler.shared.appWasOpened = true
            print("837462")
        }

//        let notification = Notification()
//        notification.prepNotification()

        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            //User has not indicated their choice for app tracking
            //You may want to show a pop-up explaining why you are collecting their data
            //Toggle any variables to do this here
        } else {
            ATTrackingManager.requestTrackingAuthorization { status in
                //Whether or not user has opted in initialize GADMobileAds here it will handle the rest
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            }
        }

        UNUserNotificationCenter.current().delegate = NotificationHandler.shared
        let tempAPI = APIRequest(quoteArr: [""], linkArr: [""])
        
        // For actual implementation
        
        // Remove previous requests first
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // Add requests for next 14 days with a different quote in each
//        for numDays in (0...13) {
//            let newDate = Calendar.current.date(byAdding: .day, value: numDays, to: Date())
//            let dateDay = Calendar.current.component(.day, from: newDate!)
//
//            tempAPI.getQuoteString { stringTuple in
//                let fact = stringTuple[0]
//                let link = stringTuple[1]
//                NotificationHandler.shared.addNotification(
//                    id : "com.historicalfacts.notif.id" + String(dateDay),
//                    title:"Historical Facts" , subtitle: fact, link: link, date: dateDay)
//            }
//        }
        
        // For testing
        let numDays = 0
        let newDate = Calendar.current.date(byAdding: .day, value: numDays, to: Date())
        let dateDay = Calendar.current.component(.day, from: newDate!)
        tempAPI.getQuoteString { stringTuple in
            let fact = stringTuple[0]
            let link = stringTuple[1]
            NotificationHandler.shared.addNotification(
                       id : "com.historicalfacts.notif.id" + String(dateDay),
                       title:"Historical Facts" , subtitle: fact, link: link, date: dateDay)
        }
        

        return true
    }

}

