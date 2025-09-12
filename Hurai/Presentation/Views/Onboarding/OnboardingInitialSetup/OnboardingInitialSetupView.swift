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
        VStack {
            Button("뒤로가기") {
                viewModel.setupPage -= 1
            }
            .disabled(viewModel.setupPage == 0)
            
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
            .padding(20)
            
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
}


#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

