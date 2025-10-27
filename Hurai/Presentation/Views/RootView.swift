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
        NavigationStack {
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
    }
    
    @ViewBuilder
    func tabbar() -> some View {
        HStack {
            HStack {
                Spacer()
                
                Image(systemName: "house.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(tag == 0 ? .accent : .white.opacity(0.2))
                
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
                
                Image(.huraiSilhouette)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 37, height: 43)
                    .foregroundStyle(tag == 1 ? .accent : .white.opacity(0.2))
                
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
