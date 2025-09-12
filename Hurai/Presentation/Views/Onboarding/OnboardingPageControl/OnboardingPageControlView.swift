//
//  OnboardingPageControlView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI

struct OnboardingPageControlView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.onboardingPage) {
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
            
            PageControlIndicator(count: 4, page: $viewModel.onboardingPage)
            
            HuraiButton(title: viewModel.onboardingPage == 3 ? "시작하기" : "다음") {
                if viewModel.onboardingPage < 3 {
                    withAnimation {
                        viewModel.onboardingPage += 1
                    }
                } else {
                    withAnimation(.easeInOut(duration: 3)){
                        viewModel.showSetupView = true
                    }
                }
            }
        }
        .animation(.default, value: viewModel.onboardingPage)
        .navigationDestination(isPresented: $viewModel.showSetupView) {
            OnboardingInitialSetupView()
                .environmentObject(viewModel)
        }
        .background(.huraiBackground)
    }
}

struct PageControlIndicator: View {
    let count: Int
    @Binding var page: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...count - 1, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.huraiAccent)
                    .opacity(index == page ? 1 : 0.3)
                    .onTapGesture {
                        if index > page {
                            withAnimation {
                                page += 1
                            }
                        } else if index < page {
                            withAnimation {
                                page -= 1
                            }
                        }
                    }
                    .animation(.easeInOut, value: page)
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(OnboardingViewModel())
}

