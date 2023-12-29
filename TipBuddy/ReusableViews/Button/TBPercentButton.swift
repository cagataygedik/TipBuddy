//
//  TBButton.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 29.12.2023.
//

import UIKit

class TBPercentButton: UIButton {
    private let tip: TipEnum
    
    init(tip: TipEnum) {
        self.tip = tip
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 8
        backgroundColor = ThemeColor.primaryColor
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white])
        text.addAttributes([.font: ThemeFont.demibold(ofSize: 14)], range: NSMakeRange(2, 1))
        setAttributedTitle(text, for: .normal)
    }
}
