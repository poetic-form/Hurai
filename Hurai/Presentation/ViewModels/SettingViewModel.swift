//
//  SettingViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    let storage: AppInfo = .init()
    
    @Published var isOnPause: Bool = false
    
    init() {
        isOnPause = storage.isOnPause
    }
    
    func updateIsOnPause() {
        storage.isOnPause = isOnPause
    }
}
