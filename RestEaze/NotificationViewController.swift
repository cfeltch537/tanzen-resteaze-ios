//
//  NotificationViewController.swift
//  RestEaze
//
//  Created by William Jones on 8/20/21.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    @IBAction func NotificationClicked(_ sender: Any) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Creating Notifications Example"
        notificationContent.subtitle = "This is how a notification would be created"
        notificationContent.body = "This is the notification body"
        notificationContent.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "RestEazeNotification", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
