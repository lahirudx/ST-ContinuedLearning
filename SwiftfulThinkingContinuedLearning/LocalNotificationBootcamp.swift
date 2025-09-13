//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-13.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error requesting authorization: \(error)")
            } else {
                print("Successfully requested authorization")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello, World!"
        content.subtitle = "This is a test notification."
        content.sound = .default
        content.badge = 1
        
        //time
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 13
//        dateComponents.minute = 59
//        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //location
//        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 32.6514, longitude: -161.4333)
//        let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
//        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: timeTrigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40.0) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification") {
                NotificationManager.instance.cancelAllNotifications()
            }
            .tint(.red)
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
