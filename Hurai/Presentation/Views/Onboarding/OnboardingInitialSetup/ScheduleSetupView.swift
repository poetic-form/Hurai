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
        VStack {
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

