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
    
    @AppStorage("startInterval") var startInterval: Date = .now
    @AppStorage("endInterval") var endInterval: Date = .now + 3600
    @AppStorage("threshold") var threshold: Int = 15
    @AppStorage("settingTiming", store: UserDefaults(suiteName: Bundle.main.appGroupName)) var settingTiming: Date = .now
   
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
    
    func originMonitoring() {
        usecase.originStartMonitoring(start: startInterval, end: endInterval, apps: store.selections, threshold: DateComponents(minute: threshold))
        settingTiming = .now
    }
}

extension Date: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(Date.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
