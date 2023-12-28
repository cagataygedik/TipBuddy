//
//  TBAmountView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 28.12.2023.
//

import UIKit

class TBAmountView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .purple
    }
}
