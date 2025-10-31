//
//  MixpanelManager.swift
//  Hurai
//
//  Created by Sihyeong Lee on 10/29/25.
//

import Foundation
import Mixpanel

class MixpanelManager {
    static let shared = MixpanelManager()
    
    private init() {}
    
    func initialize() {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "TOKEN") as? String else { return }
        Mixpanel.initialize(token: token, trackAutomaticEvents: false)
    }
    
    func trackMissionStarted(selectedApps: Int, intervalStart: Date, intervalEnd: Date, threshold: Int, screen: String) {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let intervalStartISO = isoFormatter.string(from: intervalStart)
        let intervalEndISO = isoFormatter.string(from: intervalEnd)

        Mixpanel.mainInstance().track(event: "Create Schedule", properties: [
            "selected_app_count": selectedApps,
            "interval_start": intervalStartISO,
            "interval_end": intervalEndISO,
            "threshold": threshold,
            "screen_name": screen
        ])
    }
    
    func trackOnboardingComplete() {
        Mixpanel.mainInstance().track(event: "Onboarding Complete")
    }
    
    func trackEnterMissionView() {
        Mixpanel.mainInstance().track(event: "Enter MissionView")
    }
    
    func trackCompleteMission() {
        Mixpanel.mainInstance().track(event: "Complete Mission")
    }
    
    func trackRecreateSchedule(repeatCount: Int) {
        Mixpanel.mainInstance().track(event: "Recreate Schedule", properties: [
            "repeat_count": repeatCount
        ])
    }
}
