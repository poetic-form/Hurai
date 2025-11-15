//
//  GetStartedView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct GetStartedView: View {
    var title: String = "지금부터 후라이와\n건강한 수면습관을 만들어요!"
    var subtitle: String = "\n"
    var image: ImageResource = .huraiOnboarding4
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .pretendard(.semibold, 28)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
            
            Spacer()
                .frame(height: 70)
            
            Image(image)
                .resizable()
                .frame(width: 276, height: 302)
        }
        .frame(alignment: .top)
    }
}

#Preview {
    GetStartedView()
}
