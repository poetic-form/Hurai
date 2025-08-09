//
//  HomeViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import Foundation
import FamilyControls
import SwiftUI
import ManagedSettings

class HomeViewModel: ObservableObject {
    let store: DiscourageInfoStore = .init()
    let usecase: DeviceActivityUseCase = .init()
    
    @Published var showSelectionPicker: Bool = false
    @Published var showThresholdPicker: Bool = false
   
    var selections:FamilyActivitySelection {
        get { store.selections }
        set { store.selections = newValue }
    }
    
    var selectionsBinding: Binding<FamilyActivitySelection> {
        Binding(
            get: { self.store.selections },
            set: { self.store.selections = $0 }
        )
    }
    
    var threshold:Int {
        get { store.threshold }
        set { store.threshold = newValue }
    }
    
    var thresholdBinding: Binding<Int> {
        Binding(
            get: { self.store.threshold },
            set: { self.store.threshold = $0 }
        )
    }
    
    func action() {
        usecase.startMonitoring(apps: self.selections, threshold: DateComponents(minute: self.threshold))
        print(self.threshold)
    }
}
