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
    let applock: AppLockUseCase = .init()
    
    @Published var showSelectionPicker: Bool = false
    @Published var showThresholdPicker: Bool = false
    @Published var showMissionView: Bool = false
    
    @Published var startInderval: Date = .now
    @Published var endInderval: Date = .now + 30
   
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
    
    func originMonitoring() {
        usecase.originStartMonitoring(start: startInderval, end: endInderval, apps: store.selections, threshold: DateComponents(minute: threshold))
    }
}
