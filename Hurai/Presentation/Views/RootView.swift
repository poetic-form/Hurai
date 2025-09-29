//
//  RootView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct RootView: View {
    @State var tag: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $tag) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                    }
                    .tag(1)
            }
            
            tabbar()
        }
    }
    
    @ViewBuilder
    func tabbar() -> some View {
        HStack {
            HStack {
                Spacer()
                
                Image(systemName: "house.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(tag == 0 ? .accent : .gray)
                
                Spacer()
                    .frame(width: 60)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                tag = 0
            }
            
            HStack {
                Spacer()
                    .frame(width: 60)
                
                Image(systemName: "gear")
                    .font(.system(size: 36))
                    .foregroundStyle(tag == 1 ? .accent : .gray)
                
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                tag = 1
            }
        }
        .frame(height: 70)
        .background(.huraiBackground)
    }
}

#Preview {
    RootView()
        .environmentObject(HomeViewModel())
        .environmentObject(SettingViewModel())
        .environmentObject(MissionViewModel())
}
