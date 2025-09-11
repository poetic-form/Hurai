//
//  ThresholdSetupView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/10/25.
//

import SwiftUI

struct ThresholdSetupView: View {
    @Binding var page: Int
    
    var body: some View {
        VStack {
            Spacer()
            
            HuraiButton(title: "다음") {
                page += 1
            }
        }
    }
}

#Preview {
    ThresholdSetupView(page: .constant(0))
}
