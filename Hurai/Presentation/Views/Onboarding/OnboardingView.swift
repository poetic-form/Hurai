//
//  OnboardingView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/5/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel = OnboardingViewModel()
    
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
                Label("후라이 스플래시뷰", systemImage: "star.fill")
                    .pretendard(.bold, 20)
                    .foregroundStyle(.white)
            }
    }
}

//#Preview {
//    OnboardingView()
//}

