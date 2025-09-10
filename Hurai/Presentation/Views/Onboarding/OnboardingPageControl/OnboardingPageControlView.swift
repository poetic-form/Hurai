//
//  OnboardingPageControlView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI

struct OnboardingPageControlView: View {
    @State private var currentPage: Int = 0
    @State private var nav: Bool = false
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                WelcomView()
                    .tag(0)
                
                ScreenTimeOverviewView()
                    .tag(1)
                
                MissionOverviewView()
                    .tag(2)
                
                GetStartedView()
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            PageControlIndicator(count: 4, currentPage: $currentPage)
            
            HuraiButton(title: currentPage == 3 ? "시작하기" : "다음") {
                if currentPage < 3 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 3)){
                        nav = true
                    }
                }
            }
        }
        .navigationDestination(isPresented: $nav) {
            OnboardingInitialSetupView()
        }
        .background(.huraiBackground)
    }
}

struct PageControlIndicator: View {
    let count: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...count - 1, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.huraiAccent)
                    .opacity(index == currentPage ? 1 : 0.3)
                    .onTapGesture {
                        if index > currentPage {
                            withAnimation {
                                currentPage += 1
                            }
                        } else if index < currentPage {
                            withAnimation {
                                currentPage -= 1
                            }
                        }
                    }
                    .animation(.easeInOut, value: currentPage)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
