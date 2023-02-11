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
    
    @State var randIdx = Int.random(in: 0...Quote.sampleData.count-1)
    
    //Use init() in place of ApplicationDidFinishLaunchWithOptions in App Delegate
    init() {
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
        
        let notification = Notification()
        notification.prepNotification(randIdx: $randIdx)
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FactView(quoteData: Quote.sampleData, randIdx: $randIdx)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    
    
}
