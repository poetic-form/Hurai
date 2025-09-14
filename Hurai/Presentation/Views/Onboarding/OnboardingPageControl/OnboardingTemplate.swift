//
//  OnboardingTemplate.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct OnboardingTemplate: View {
    var title: String = ""
    var subtitle: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .pretendard(.bold, 26)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: 45)
            
            Rectangle()
                .frame(width: 228, height: 250)
                .foregroundStyle(.gray)
            
            Spacer()
                .frame(height: 76)
            
            Text(subtitle)
                .pretendard(.regular, 16)
                .foregroundStyle(.huraiGray)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    OnboardingTemplate()
}
