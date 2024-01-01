//
//  TBLabel.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit

class TBLabel: UILabel {
    
    convenience init(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.textColor!,
        textAlignment: NSTextAlignment = .center
    ) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
