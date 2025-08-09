//
//  ThresholdPickerView.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import SwiftUI

struct ThresholdPickerView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("목표 시간 설정", selection: viewModel.thresholdBinding) {
                    ForEach(0...10, id: \.self) { index in
                        Text("\(index)분")
                    }
                }
                .pickerStyle(.wheel)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        viewModel.showThresholdPicker = false
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    ThresholdPickerView()
//}
