//
//  DiscourageInfoStore.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import FamilyControls
import SwiftUI

final class AppInfo {
    @AppStorage("selections", store: UserDefaults(suiteName: Bundle.main.appGroupName))
    var selections: FamilyActivitySelection = FamilyActivitySelection(includeEntireCategory: true)
    
    @AppStorage("threshold")
    var threshold: Int = 2
   
    @AppStorage("startInterval")
    var startInterval: Date = .now
    
    @AppStorage("endInterval")
    var endInterval: Date = .now + 3600
    
    @AppStorage("isFirst")
    var isFirst: Bool = true
    
    @AppStorage("isOnPause")
    var isOnPause: Bool = false
    
    init() { }
}
