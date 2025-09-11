//
//  ThresholdSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct ThresholdSetupView: View {
    @AppStorage("isFirst") var isFirst: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            
            HuraiButton(title: "다음") {
                isFirst = false
            }
        }
    }
}

#Preview {
    OnboardingInitialSetupView()
        .environmentObject(OnboardingViewModel())
}

