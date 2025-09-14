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
            title: "잠들기 어렵게 만드는\n앱 사용을 제한해요",
            subtitle: "잠들기 전 자주 사용하는 앱을 선택하면\n사용시간을 조절할 수 있게 도와드려요"
        )
    }
}

#Preview {
    ScreenTimeOverviewView()
}
