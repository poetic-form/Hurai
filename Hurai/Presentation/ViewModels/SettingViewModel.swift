//
//  SettingViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/9/25.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    let store: AppStateStore = .init()
    
    var isInRestMode:Bool {
        get { store.isInRestMode }
        set { store.isInRestMode = newValue }
    }
    
    var isInRestModeBinding: Binding<Bool> {
        Binding(
            get: { self.store.isInRestMode },
            set: { self.store.isInRestMode = $0 }
        )
    }
}
