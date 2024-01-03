//
//  TBSettingsOption.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 2.01.2024.
//

import UIKit

enum TBSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case contributor
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return Strings.twitterUrl
        case .contributor:
            return nil
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Me on X (Twitter)"
        case .contributor:
            return "Contributor"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .contributor:
            return UIImage(systemName: "person")
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return ThemeColor.primaryColor
        case .contactUs:
            return ThemeColor.primaryColor
        case .contributor:
            return ThemeColor.primaryColor
        }
    }
}
