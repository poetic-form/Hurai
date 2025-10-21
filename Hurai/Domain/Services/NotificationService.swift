//
//  NotificationUseCase.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import UserNotifications

class NotificationService {
    let center = UNUserNotificationCenter.current()
    
    init() { }
    
    func requestNotificationAuthorization() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("알림 권한 허용됨")
            } else {
                print("알림 권한 거부됨: \(error?.localizedDescription ?? "없음")")
            }
        }
    }
    
    func warningNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

      center.add(request) { error in
            if let error = error {
                print("알림 등록 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func missionNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = ["url": "hurai://mission"]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

      center.add(request) { error in
            if let error = error {
                print("알림 등록 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleDailyMorningNotification(title: String, body: String) {
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: "dailyMorningNotification",
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let error = error {
                print("매일 알림 등록 실패: \(error.localizedDescription)")
            } else {
                print("매일 아침 9시 알림 등록 완료")
            }
        }
    }
    
    func removeDailyMorningNotification() {
        center.removePendingNotificationRequests(withIdentifiers: ["dailyMorningNotification"])
    }
}
