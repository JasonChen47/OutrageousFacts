//
//  NotificationViewController.swift
//  Outrageous Facts
//
//  Created by John Smith on 2/5/23.
//

import Foundation
import UIKit
import SwiftUI

class Notification {
    func prepNotification(randIdx: Binding<Int>) {

//        var quoteData: [Quote] = Quote.sampleData
//        let quote: String = quoteData[randIdx].quote
        
        // Ask for permission
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        // Content for notification
        let content = UNMutableNotificationContent()
        content.title = "History Facts"
        content.body = "Come check out the history fact for today!"
        
        // Setting the time of repeat
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 20
        dateComponents.minute = 47
        dateComponents.timeZone = TimeZone(identifier: "UTC")
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (15), repeats: true)
        
        // Register the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule the request with the system
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                print(1337)
            }
        }
        print(trigger.nextTriggerDate() as Any)
        print(1242)
    }
}


