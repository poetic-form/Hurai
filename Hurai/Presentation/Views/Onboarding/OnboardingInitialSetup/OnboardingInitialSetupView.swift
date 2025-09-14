//
//  OnboardingInitialSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI

struct OnboardingInitialSetupView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                backButton()
                
                HStack(spacing: 20) {
                    ForEach(0...3, id: \.self) { index in
                        if index <= viewModel.setupPage {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 75, height: 6)
                                .foregroundStyle(.huraiAccent)
                        } else {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 75, height: 6)
                                .foregroundStyle(.white.opacity(0.1))
                        }
                    }
                }
            }
            .padding(20)
            .onAppear {
                viewModel.setupPage = 2
            }
            
            switch viewModel.setupPage {
            case 0:
                PermissionRequestView()
            case 1:
                AppSelectionView()
            case 2:
                ScheduleSetupView()
            case 3:
                ThresholdSetupView()
            default:
                EmptyView()
            }
        }
        .background(.huraiBackground)
        .navigationBarBackButtonHidden()
        .animation(.easeInOut(duration: 0.1), value: viewModel.setupPage)
    }
    
    @ViewBuilder
    func backButton() -> some View {
        HStack {
            if viewModel.setupPage != 0 {
                Button {
                    if viewModel.setupPage > 0 {
                        viewModel.setupPage -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(height: 20)
                        .scaledToFit()
                        .padding(5)
                        .foregroundStyle(.huraiWhite)
                }
            }
            
            Spacer()
        }
        .frame(height: 40)
    }
}


#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

