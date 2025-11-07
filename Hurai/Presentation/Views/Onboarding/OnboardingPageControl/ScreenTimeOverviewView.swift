//
//  ScreenTimeOverviewView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct ScreenTimeOverviewView: View {
    var body: some View {
        OnboardingTemplate(
            title: "잠들기 전 앱 사용시간을\n조절할 수 있어요",
            subtitle: "잠들기 전 자주 사용하는 앱을 선택하면\n사용시간을 조절할 수 있게 도와줘요",
            image: .huraiOnboarding2
        )
    }
}

#Preview {
    ScreenTimeOverviewView()
}
