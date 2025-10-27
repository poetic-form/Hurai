//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitorExtension
//
//  Created by Sihyeong Lee on 8/2/25.
//

import DeviceActivity
import Foundation
import SwiftUI

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let notificationService: NotificationService = .init()
    let appLockService: AppLockService = .init()
    let deviceActivityService: DeviceActivityService = .init()
    let storage: AppInfo = .init()
    
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    @AppStorage("registeredAt", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var registeredAt: Date = .now
    @AppStorage("isDefered", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var isDefered: Bool = false
    @AppStorage("missionState", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var missionState: Int = 0
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
        if let interval = deviceActivityService.center.schedule(for: .activity)?.nextInterval {
            if !interval.contains(registeredAt) {
                missionState = 0
            }
        }
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        if let interval = deviceActivityService.center.schedule(for: .activity)?.nextInterval {
            if !interval.contains(registeredAt) {
                if repeatCount == 0 {
                    missionState = 2
                }
                repeatCount = 0
            }
        }
        
        appLockService.unlockAllApps()
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
        isDefered = true
        appLockService.lockApps(apps: storage.selections)
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
        notificationService.warningNotification(title: "경고", body: "1분 남았습니다")
    }
}
