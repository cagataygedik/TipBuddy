//
//  TBSettingsCellViewModel.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 2.01.2024.
//

import UIKit

struct TBSettingsCellViewModel: Identifiable {
    let id = UUID()
    
    public let type: TBSettingsOption
    public let onTapHandler: (TBSettingsOption) -> Void
    
    init(type: TBSettingsOption, onTapHandler: @escaping (TBSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    public var image: UIImage? { return type.iconImage }
    
    public var title: String { return type.displayTitle }
    
    public var iconContainerColor: UIColor { return type.iconContainerColor }
}
