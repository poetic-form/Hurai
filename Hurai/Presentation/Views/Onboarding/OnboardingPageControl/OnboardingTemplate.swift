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
    var image: ImageResource
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .pretendard(.bold, 26)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
            
            Spacer()
                .frame(height: 36)
            
            Image(image)
                .resizable()
                .frame(width: 228, height: 250)
            
            Spacer()
                .frame(height: 76)
            
            Text(subtitle)
                .pretendard(.regular, 16)
                .foregroundStyle(.huraiGray)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(height: 476, alignment: .top)
    }
}

//#Preview {
//    OnboardingTemplate()
//}
