//
//  NotificationHandler.swift
//  Outrageous Facts
//
//  Created by John Smith on 4/20/23.
//

import UserNotifications
import Foundation
import SwiftUI

class NotificationHandler : NSObject, UNUserNotificationCenterDelegate{
    // Check if the app was just opened from a notification
    static let shared = NotificationHandler(appWasOpened: false, contentBody: "")
    
    @State var appWasOpened: Bool
    var contentBody: String
    
    private init(appWasOpened: Bool, contentBody: String) {
        // now we can only create new instances within NotificationHandler
        self.appWasOpened = appWasOpened
        self.contentBody = contentBody
    }
   
    @State private var initialFact = "hi"
    /** Handle notification when app is in background */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response:
        UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        // Assign the response name to a struture under NSNotification.Name
        let notiName = NSNotification.Name(response.notification.request.identifier)
        NotificationCenter.default.post(name:notiName , object: response.notification.request.content)
        NotificationHandler.shared.appWasOpened = true
        self.contentBody = response.notification.request.content.body
        print("1774")
        print(response)
        print("NotificationHandler was opened: \(NotificationHandler.shared.appWasOpened)")
        completionHandler()
    }

    /** Handle notification when the app is in foreground */
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
//             withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//        let notiName = NSNotification.Name( notification.request.identifier )
//        NotificationCenter.default.post(name:notiName , object: notification.request.content)
//        print("1789")
//        completionHandler(.banner)
//    }
}


extension NotificationHandler  {
    func requestPermission(_ delegate : UNUserNotificationCenterDelegate? = nil ,
        onDeny handler :  (()-> Void)? = nil){  // an optional onDeny handler is better here,
                                                // so there is an option not to provide one, have one only when needed
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings(completionHandler: { settings in
        
            if settings.authorizationStatus == .denied {
                if let handler = handler {
                    handler()
                }
                return
            }
            
            if settings.authorizationStatus != .authorized  {
                center.requestAuthorization(options: [.alert, .sound, .badge]) {
                    _ , error in
                    
                    if let error = error {
                        print("error handling \(error)")
                    }
                }
            }
            
        })
        center.delegate = delegate ?? self
    }
}


extension NotificationHandler {
    func addNotification(id : String, title : String, subtitle : String, link: String,
                         sound : UNNotificationSound = UNNotificationSound.default, date: Int) {
        
        
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = subtitle
        content.accessibilityLabel = link
//        content.sound = sound
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.day = date
        dateComponents.hour = 15
        dateComponents.minute = 15
        dateComponents.second = 0
        
        // For actual implementation
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: false)
        
        // For testing (not for current setup -> just change the time above)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
        print(trigger.nextTriggerDate() as Any)
    }

    func removeNotifications(_ ids : [String]){
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ids)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }

}
