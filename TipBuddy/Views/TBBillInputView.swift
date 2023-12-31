//
//  TBBillInputView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class TBBillInputView: UIView {
    
    private let headerView = TBHeaderView(topText: "Enter", bottomText: "your bill")
    private let textFieldContainerView = TBTextFieldContainerView()
    private let currencyLabel = TBLabel(text: "$", font: ThemeFont.bold(ofSize: 24))
    private let textField = TBTextField()
    
    private var cancellables = Set<AnyCancellable>()
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }

    init() {
        super.init(frame: .zero)
        layout()
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        observe()
    }
    
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.doubleValue ?? 0)
            print("\(text)")
        }.store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(headerView)
        addSubview(textFieldContainerView)
        
        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(textFieldContainerView.snp.left).offset(-24)
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyLabel)
        textFieldContainerView.addSubview(textField)
        
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(textFieldContainerView.snp.left).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(currencyLabel.snp.right).offset(16)
            make.right.equalTo(textFieldContainerView.snp.right).offset(-16)
        }
    }
}
