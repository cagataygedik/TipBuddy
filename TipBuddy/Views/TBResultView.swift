//
//  TBResultView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit

class TBResultView: UIView {
    
    private let headerLabel = TBLabel(text: "Total p/person", font: ThemeFont.demibold(ofSize: 18), textColor: .black)
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes: [.font: ThemeFont.bold(ofSize: 48), .foregroundColor: UIColor.black])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24), .foregroundColor: UIColor.black], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separatorColor
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, amountPerPersonLabel, horizontalLineView, horizontalStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let amountViewOne = TBAmountView(title: "Total Bill", textAlignment: .left, amountLabelIdentifier: "$0")
    private let amountViewTwo = TBAmountView(title: "Total Tip", textAlignment: .right, amountLabelIdentifier: "$0")
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [amountViewOne, UIView(), amountViewTwo])
        stackView.axis = .horizontal
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
        backgroundColor = .white
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.left.equalTo(snp.left).offset(24)
            make.right.equalTo(snp.right).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12, opacity: 0.1)
    }
}
