//
//  RootView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct RootView: View {
    @State private var showMissionView: Bool = false
    
    var body: some View {
        Button("misson") {
            showMissionView = true
        }
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            SettingView()
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
            Button("닫기") {
                showMissionView = false
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(HomeViewModel())
        .environmentObject(SettingViewModel())
}
