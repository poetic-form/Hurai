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
            Spacer()
                .frame(maxHeight: 30)
            Text(title)
                .pretendard(.semibold, 28)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
            
            Spacer()
                .frame(height: 25)
            
            Image(image)
                .resizable()
                .frame(width: 256, height: 280)
            
            Spacer()
                .frame(height: 68)
            
            Text(subtitle)
                .pretendard(.regular, 16)
                .foregroundStyle(.huraiLightGray)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(alignment: .top)
    }
}

//#Preview {
//    OnboardingTemplate()
//}
