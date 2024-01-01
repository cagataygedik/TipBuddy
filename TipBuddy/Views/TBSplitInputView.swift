//
//  TBSplitInputView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class TBSplitInputView: UIView {
    
    private let headerView = TBHeaderView(topText: "Split", bottomText: "the total")
    private let decrementButton = TBOperatorButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
    private let quantityLabel = TBLabel(text: "1", font: ThemeFont.bold(ofSize: 20), backgroundColor: .white, textColor: UIColor.black)
    private let incrementButton = TBOperatorButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decrementButton, quantityLabel, incrementButton])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private let splitSubject = CurrentValueSubject<Int, Never>.init(1)
    public var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    private func configureButtons() {
        decrementButton.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.assign(to: \.value, on: splitSubject).store(in: &cancellables)
        
        incrementButton.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject).store(in: &cancellables)
    }
    
    private func observe() {
        splitSubject.sink { [unowned self] quantity in
            quantityLabel.text = quantity.stringValue
        }.store(in: &cancellables)
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        configureButtons()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(headerView)
        addSubview(horizontalStackView)
        
        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(horizontalStackView.snp.left).offset(-24)
            make.centerY.equalTo(horizontalStackView.snp.centerY)
            make.width.equalTo(68)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
        }
        
        decrementButton.snp.makeConstraints { make in
            make.width.equalTo(snp.height)
        }
        
        incrementButton.snp.makeConstraints { make in
            make.width.equalTo(snp.height)
        }
    }
}
