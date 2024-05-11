//
//  Copyright © 2024 Judit Karamazov. All rights reserved.
//

import Foundation
import UserNotifications

func sendNotification(body: String = "") {
  let content = UNMutableNotificationContent()
  content.title = "mergeOS"

  if body.count > 0 {
    content.body = body
  }

  let uuidString = UUID().uuidString
  let request = UNNotificationRequest(
    identifier: uuidString,
    content: content, trigger: nil)

  let notificationCenter = UNUserNotificationCenter.current()
  notificationCenter.requestAuthorization(options: [.alert, .sound]) { _, _ in }
  notificationCenter.add(request)
}
