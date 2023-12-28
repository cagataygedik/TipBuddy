//
//  TBTextFieldContainerView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 28.12.2023.
//

import UIKit

class TBTextFieldContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.masksToBounds = false
        layer.cornerRadius = 8
    }
}
