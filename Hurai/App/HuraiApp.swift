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
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RootView()
                
                if isFirst {
                    OnboardingView()
                        .transition(.move(edge: .bottom))
                        .zIndex(1)
                }
            }
            .onOpenURL { url in
                if(url.scheme == "hurai" && url.host == "mission") {
                    missionVM.showMissionView = true
                }
            }
            .fullScreenCover(isPresented: $missionVM.showMissionView) {
                MissionView(
                    flipMotionService: .init(requiredHoldDuration: 3 * (repeatCount + 1))
                )
            }
            .environmentObject(missionVM)
            .environmentObject(homeVM)
            .environmentObject(settingVM)
            .animation(.easeInOut, value: isFirst)
        }
    }
}
