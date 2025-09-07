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
    @AppStorage("isFirst") var isFirst: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                OnboardingView()
                    .opacity(isFirst ? 1 : 0)
                
                RootView()
                    .opacity(isFirst ? 0 : 1)
            }
            .environmentObject(homeVM)
            .environmentObject(settingVM)
            .environmentObject(missionVM)
            .onAppear {
                print(isFirst)
            }
        }
    }
}
