//
//  DiscourageInfoStore.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import FamilyControls
import SwiftUI

final class DiscourageInfoStore: ObservableObject {
    static let shared = DiscourageInfoStore()
    
    @AppStorage("selections", store: UserDefaults(suiteName: "group.poeticform.Hurai")) private var selections: FamilyActivitySelection = FamilyActivitySelection()
    
    @AppStorage("goalTime") private var goalTime: Int = 0
    private init() { }
}
