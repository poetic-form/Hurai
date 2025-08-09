//
//  RootView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
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
    }
}

#Preview {
    RootView()
}
