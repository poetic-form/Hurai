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
    @StateObject private var missionVM: MissionViewModel = MissionViewModel.shared
   
    @AppStorage("isFirst") var isFirst: Bool = true
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    
    init() {
        UITabBar.appearance().isHidden = true
        MixpanelManager.shared.initialize()
    }
    
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
            .dynamicTypeSize(.medium)
            .onOpenURL { url in
                if(url.scheme == "hurai" && url.host == "mission") {
                    missionVM.showMissionView = true
                    MixpanelManager.shared.trackEnterMissionView()
                }
            }
            .fullScreenCover(isPresented: $missionVM.showMissionView, onDismiss: homeVM.fetchAllInfos) {
                MissionView(
                    flipMotionService: .init(requiredHoldDuration: 3 * (repeatCount + 1))
                )
                .dynamicTypeSize(.medium)
            }
            .preferredColorScheme(.dark)
            .environmentObject(missionVM)
            .environmentObject(homeVM)
            .environmentObject(settingVM)
            .animation(isFirst ? .none : .easeInOut, value: isFirst)
            .onChange(of: isFirst) { newValue in
                homeVM.fetchAllInfos()
            }
        }
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1 && (!MissionViewModel.shared.showMissionView && !OnboardingViewModel.shared.showSetupView)
    }
}
