//
//  OnboardingView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/5/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isActive = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                SplashView()
                    .opacity(isActive ? 1 : 0)
                    .onAppear {
                        toggleActive()
                    }
                
                OnboardingPageControlView()
                    .opacity(isActive ? 0 : 1)
            }
        }
    }
    
    func toggleActive() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut) {
                isActive = false
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
       Rectangle()
            .foregroundStyle(.black)
            .ignoresSafeArea()
            .overlay {
                Label("후라이 스플래시뷰", systemImage: "star.fill")
                    .pretendard(.bold, 20)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    OnboardingView()
}
