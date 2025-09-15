//
//  ShieldActionExtension.swift
//  ShieldActionExtension
//
//  Created by Sihyeong Lee on 8/2/25.
//

import ManagedSettings
import SwiftUI

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    @AppStorage("isDefered", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var isDefered: Bool = false
    
    let notificationService: NotificationService = .init()
    
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
            notificationService.missionNotification(title: "후라이", body: "미션하러가기")
            isDefered.toggle()
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        completionHandler(.close)
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        completionHandler(.close)
    }
}
