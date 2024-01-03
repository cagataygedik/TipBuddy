//
//  TBAmountView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 28.12.2023.
//

import UIKit

class TBAmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel = TBLabel(text: title, font: ThemeFont.regular(ofSize: 18), textColor: UIColor.black, textAlignment: textAlignment)
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primaryColor
        let text = NSMutableAttributedString(string: 0.currencyFormatted, attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        stackView.axis = .vertical
        return stackView
    }()

    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(string: amount.currencyFormatted, attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
