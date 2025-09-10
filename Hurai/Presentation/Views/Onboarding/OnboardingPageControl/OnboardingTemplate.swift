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
        VStack {
            Text(title)
                .pretendard(.bold, 26)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Rectangle()
                .frame(width: 228, height: 250)
                .foregroundStyle(.gray)
            
            Text(subtitle)
                .pretendard(.regular, 16)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    OnboardingTemplate()
}
