//
//  TBTipInputView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

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
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
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
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    public var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    private func configureButtons() {
        tenPercentButton.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        
        fifteenPercentButton.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        
        twentyPercentButton.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
    }
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(title: "Enter your tip", message: nil, preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Excite the waiter!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
                textField.clearButtonMode = .whileEditing
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let doneAction = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text, let value = Int(text) else {return}
                self?.tipSubject.send(.customTip(value: value))
            }
            [doneAction, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentButton.backgroundColor = ThemeColor.secondaryColor
            case .fifteenPercent:
                fifteenPercentButton.backgroundColor = ThemeColor.secondaryColor
            case .twentyPercent:
                twentyPercentButton.backgroundColor = ThemeColor.secondaryColor
            case .customTip(let value):
                customTipButton.backgroundColor = ThemeColor.secondaryColor
                let text = NSMutableAttributedString(string: "$\(value)", attributes: [.font: ThemeFont.bold(ofSize: 20)])
                text.addAttributes([.font: ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    private func resetView() {
        [tenPercentButton, fifteenPercentButton, twentyPercentButton, customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primaryColor
        }
        let text = NSMutableAttributedString(string: "Custom Tip", attributes: [.font: ThemeFont.bold(ofSize: 20)])
        customTipButton.setAttributedTitle(text, for: .normal)
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
