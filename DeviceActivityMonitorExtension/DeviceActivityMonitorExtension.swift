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
    let notificationUseCase: NotificationUseCase = .init()
    let appLockUseCase: AppLockUseCase = .init()
    let deviceActivityUsecase: DeviceActivityUseCase = .init()
    let store: DiscourageInfoStore = .init()
    
    @AppStorage("times", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var times: TimeInterval = 1
    
    @AppStorage("settingTiming", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var settingTiming: Date = .now
   
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        if let interval = deviceActivityUsecase.center.schedule(for: .activity)?.nextInterval {
            if !interval.contains(settingTiming) {
                times = 1
            }
        }
        
        appLockUseCase.unlockAllApps()
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
        appLockUseCase.lockApps(apps: store.selections)
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
        notificationUseCase.warningNotification(title: "경고", body: "1분 남았습니다")
    }
}

extension Date: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(Date.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
