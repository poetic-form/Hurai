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
    @AppStorage("isFirst") var isFirst: Bool = true
    
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
            .environmentObject(homeVM)
            .environmentObject(settingVM)
            .animation(.easeInOut, value: isFirst)
        }
    }
}
