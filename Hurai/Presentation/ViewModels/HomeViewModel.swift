//
//  HomeViewModel.swift
//  Hurai
//
//  Created by Sihyeong Lee on 8/6/25.
//

import Foundation
import ManagedSettings

class HomeViewModel: BasicViewModel {
    @Published var showSelectionPicker: Bool = false
    @Published var showThresholdPicker: Bool = false
    @Published var showEditSheet: Bool = false
    
    func returnApplicationTokens() -> [ApplicationToken] {
        return self.selections.applicationTokens.sorted { $0.rawValue < $1.rawValue }
    }
    
    func returnWebDomainTokens() -> [WebDomainToken] {
        return self.selections.webDomainTokens.sorted { $0.rawValue < $1.rawValue }
    }
}
