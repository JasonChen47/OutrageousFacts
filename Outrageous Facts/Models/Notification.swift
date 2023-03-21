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
    func prepNotification() {
        
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

        // For testing
//        let date = Date().addingTimeInterval(15)
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        
        // Remove previous requests
        notificationCenter.removeAllPendingNotificationRequests()
        
        // Register the request
//        let uuidString = UUID().uuidString
        let uuidString = "8e5126a0-b172-11ed-afa1-0242ac120002"
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


