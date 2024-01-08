//
//  TBHeaderView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 28.12.2023.
//

import UIKit
import SnapKit

final class TBHeaderView: UIView {
    private let topText: String
    private let bottomText: String
    
    private lazy var topLabel = TBLabel(text: topText, font: ThemeFont.bold(ofSize: 18))
    private lazy var bottomLabel = TBLabel(text: bottomText, font: ThemeFont.regular(ofSize: 16))
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -6
        return stackView
    }()
    
    init(topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
