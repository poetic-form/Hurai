//
//  HuraiButton.swift
//  Hurai
//
//  Created by Sihyeong Lee on 9/7/25.
//

import SwiftUI

struct HuraiButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.yellow)
                .frame(height: 56)
                .overlay {
                    Text("\(title)")
                        .foregroundStyle(.black)
                        .pretendard(.semibold, 18, relativeTo: .caption)
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    HuraiButton(title: "다음") {
        
    }
}
