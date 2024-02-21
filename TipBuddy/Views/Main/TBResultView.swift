//
//  TBResultView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit

final class TBResultView: UIView {
    
    private let headerLabel = TBLabel(text: "Total p/person", font: ThemeFont.demibold(ofSize: 18), textColor: .black)
    private let totalBillView = TBAmountView(title: "Total Bill", textAlignment: .left, amountLabelIdentifier: "$0")
    private let totalTipView = TBAmountView(title: "Total Tip", textAlignment: .right, amountLabelIdentifier: "$0")
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: 0.currencyFormatted, attributes: [.font: ThemeFont.bold(ofSize: 48), .foregroundColor: UIColor.black])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24), .foregroundColor: UIColor.black], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.separatorColor
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, amountPerPersonLabel, horizontalLineView, horizontalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalBillView, UIView(), totalTipView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(string: result.amountPerPerson.currencyFormatted, attributes: [.font: ThemeFont.bold(ofSize: 48), .foregroundColor: UIColor.black])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24), .foregroundColor: UIColor.black], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(180)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12, opacity: 0.1)
    }
}
