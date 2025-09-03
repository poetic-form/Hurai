//
//  HuraiApp.swift
//  Hurai
//
//  Created by Sihyeong Lee on 7/30/25.
//

import SwiftUI

@main
struct HuraiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var homeVM: HomeViewModel = HomeViewModel()
    @StateObject private var settingVM: SettingViewModel = SettingViewModel()
    @StateObject private var missionVM: MissionViewModel = MissionViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(homeVM)
                .environmentObject(settingVM)
                .environmentObject(missionVM)
        }
    }
}
