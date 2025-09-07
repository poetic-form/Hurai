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
    
    func toggleActive() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
                Image(systemName: "star.fill")
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    OnboardingView()
}
