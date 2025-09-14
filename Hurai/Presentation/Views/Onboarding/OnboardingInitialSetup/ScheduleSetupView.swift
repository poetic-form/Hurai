//
//  ScheduleSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct ScheduleSetupView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("지키고 싶은\n나의 수면시간을 알려주세요")
                        .pretendard(.bold, 24)
                        .foregroundStyle(.white)
                        .lineSpacing(8)
                    
                    Text("설정한 수면시간 동안만\n사용시간 측정과 잠금기능이 실행돼요.")
                        .pretendard(.regular, 16)
                        .foregroundStyle(.huraiGray)
                        .lineSpacing(4)
                }
                
                Spacer()
            }
            .padding(20)
            
            HuraiTimeSlider(
                startInterval: $viewModel.startInterval,
                endInterval: $viewModel.endInterval
            )
            .onDisappear {
                viewModel.updateInterval()
            }
            
            Spacer()
            
            HuraiButton(title: "다음") {
                viewModel.setupPage += 1
            }
        }
    }
}

#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

