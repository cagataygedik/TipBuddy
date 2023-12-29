//
//  TBTipInputView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit

class TBTipInputView: UIView {
    
    private let headerView = TBHeaderView(topText: "Choose", bottomText: "your tip")
    private let tenPercentButton = TBPercentButton(tip: .tenPercent)
    private let fifteenPercentButton = TBPercentButton(tip: .fifteenPercent)
    private let twentyPercentButton = TBPercentButton(tip: .twentyPercent)
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom Tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primaryColor
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tenPercentButton, fifteenPercentButton, twentyPercentButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalStackView, customTipButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(headerView)
        addSubview(verticalStackView)
        
        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(verticalStackView.snp.left).offset(-24)
            make.centerY.equalTo(horizontalStackView.snp.centerY)
            make.width.equalTo(68)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
        }
    }
}
