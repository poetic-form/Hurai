//
//  WelcomView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct WelcomView: View {
    var body: some View {
        OnboardingTemplate(
            title: "스마트폰 사용으로\n잠들기 어려운가요?",
            subtitle: "후라이는 스스로 스마트폰 사용시간을\n조절할 수 있도록 도와드려요"
        )
    }
}

#Preview {
    WelcomView()
}
