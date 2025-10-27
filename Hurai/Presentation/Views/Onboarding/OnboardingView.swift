//
//  OnboardingView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/5/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel = OnboardingViewModel.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardingPageControlView()
                    .environmentObject(viewModel)
                
                if viewModel.showSplash {
                    SplashView()
                        .onAppear {
                            viewModel.toggleSplash()
                        }
                        .zIndex(1)
                        .transition(.opacity)
                }
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
       Rectangle()
            .foregroundStyle(.huraiBackground)
            .ignoresSafeArea()
            .overlay {
                Text("Hurai")
                    .uhbee(50)
                    .foregroundStyle(.accent)
                    .overlay(alignment: .topTrailing) {
                        Image(.huraiSplash)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x:47, y:-68)
                    }
            }
    }
}

//#Preview {
//    SplashView()
//}

