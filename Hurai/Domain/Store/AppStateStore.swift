//
//  AppStateStore.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/2/25.
//

import Foundation
import SwiftUI

final class AppStateStore: ObservableObject {
    static let shared = AppStateStore()
    
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @AppStorage("isInRestMode") var isInRestMode: Bool = false
    
    private init() { }
}
