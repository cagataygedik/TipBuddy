//
//  TBTipInputView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit

class TBTipInputView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .systemBlue
    }
}
