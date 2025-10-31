//
//  SettingViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import Foundation
import SwiftUI
import Network

class SettingViewModel: BasicViewModel {
    let notificationService: NotificationService = .init()
    
    @Published var showLoading: Bool = false
    @Published var networkStatus: NWPath.Status? = nil
    
    @Published var reportTitle: String = ""
    @Published var reportEmail: String = ""
    @Published var reportMessage: String = ""
    
    func resetSetting() {
        showLoading = false
        networkStatus = nil
        reportTitle = ""
        reportEmail = ""
        reportMessage = ""
    }
    
    func checkNetworkStatus() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkCheck")
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.networkStatus = path.status
                monitor.cancel() // 확인 후 바로 종료
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func sendDiscordWebhook() {
        let webhookURL = Bundle.main.object(forInfoDictionaryKey: "WEBHOOK_URL") as? String ?? ""
        let url = URL(string: "https://" + webhookURL)!
        
        var email: String {
            if reportEmail.isEmpty {
                "미입력"
            } else {
                reportEmail
            }
        }
        
        let payload: [String: Any] = [
            "embeds": [[
                "title": "\(reportTitle)",
                "description": """
                       **📄 내용**   : \(reportMessage)
                       **📧 이메일**  : \(email)
                       """,
                "footer": [
                    "text": "Hurai Report Notification"
                ],
                "timestamp": ISO8601DateFormatter().string(from: Date())
            ]]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
        
        URLSession.shared.dataTask(with: request).resume()
    }
    
    func registNotification() {
        notificationService.scheduleDailyMorningNotification(title: "후라이", body: "잠깐 쉴래요 기능을 꺼서 오늘 하루도 목표한 시간만큼만 사용해봐요")
    }
    
    func removeNotification() {
        notificationService.removeDailyMorningNotification()
    }
}
