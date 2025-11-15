//
//  MissionOverviewView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct MissionOverviewView: View {
    var body: some View {
        OnboardingTemplate(
            title: "미션을 진행하며\n잠에 들도록 노력해요",
            subtitle: "목표 시간이 되면 스마트폰을 뒤집고\n잠들 수 있도록 미션을 제공해요",
            image: .huraiOnboarding3
        )
    }
}

#Preview {
    MissionOverviewView()
}
