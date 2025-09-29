//
//  HomeViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import Foundation

class HomeViewModel: BasicViewModel {
    @Published var showSelectionPicker: Bool = false
    @Published var showThresholdPicker: Bool = false
    @Published var showEditSheet: Bool = false
}
