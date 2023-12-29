//
//  TBOperatorButton.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 29.12.2023.
//

import UIKit

class TBOperatorButton: UIButton {
    private let text: String
    private let corners: CACornerMask
    
    init(text: String, corners: CACornerMask) {
        self.text = text
        self.corners = corners
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setTitle(text, for: .normal)
        titleLabel?.font = ThemeFont.bold(ofSize: 20)
        backgroundColor = ThemeColor.primaryColor
        addRoundedCorners(corners: corners, radius: 8.0)
    }
    
    private func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
}
