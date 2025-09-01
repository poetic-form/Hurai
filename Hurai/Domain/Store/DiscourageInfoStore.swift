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
    var selections: FamilyActivitySelection = FamilyActivitySelection(includeEntireCategory: true)
    
    @AppStorage("goalTime") var threshold: Int = 0
    
    init() { }
}

extension FamilyActivitySelection: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
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

extension Bundle {
    var appGroupName: String {
        guard let value = Bundle.main.infoDictionary?["APP_GROUP_NAME"] as? String else {
            fatalError("APP_NAME not set in Info.plist")
        }
        return value
    }
}
