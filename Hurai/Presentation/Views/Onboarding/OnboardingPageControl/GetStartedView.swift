//
//  GetStartedView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct GetStartedView: View {
    var title: String = "지금부터 후라이와\n충분한 수면시간을 만들어요!"
    var subtitle: String = "\n"
    var image: ImageResource = .huraiOnboarding4
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .pretendard(.bold, 26)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
            
            Spacer()
                .frame(height: 77)
            
            Image(image)
                .resizable()
                .frame(width: 260, height: 285)
        }
        .frame(height: 476, alignment: .top)
    }
}

#Preview {
    GetStartedView()
}
