//
//  RootView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct RootView: View {
    @State private var showMissionView: Bool = false
    @EnvironmentObject var viewModel: HomeViewModel
    @AppStorage("times", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var times: TimeInterval = 1
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            SettingView(showMissionView: $showMissionView)
                .tabItem {
                    Image(systemName: "gear")
                }
        }
        .onOpenURL { url in
            if(url.scheme == "hurai" && url.host == "mission") {
                showMissionView = true
            }
        }
        .fullScreenCover(isPresented: $showMissionView) {
            MissionView(
                showMissionView: $showMissionView,
                usecase: .init(requiredHoldDuration: 3 * times)
            )
        }
    }
}

#Preview {
    RootView()
        .environmentObject(HomeViewModel())
        .environmentObject(SettingViewModel())
}
