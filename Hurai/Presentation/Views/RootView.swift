//
//  RootView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var missionVM: MissionViewModel = MissionViewModel()
    
    @AppStorage("repeatCount", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var repeatCount: TimeInterval = 0
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            SettingView(showMissionView: $missionVM.showMissionView)
                .tabItem {
                    Image(systemName: "gear")
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
            .environmentObject(missionVM)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(HomeViewModel())
        .environmentObject(SettingViewModel())
        .environmentObject(MissionViewModel())
}
