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
    @AppStorage("selections", store: UserDefaults(suiteName: "group.poeticform.Hurai"))
    private var selections: FamilyActivitySelection = FamilyActivitySelection(includeEntireCategory: true)
    
    @AppStorage("goalTime") private var threshold: Int = 0
    
    init() { }
}
