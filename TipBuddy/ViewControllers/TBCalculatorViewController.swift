//
//  ViewController.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 25.12.2023.
//

import UIKit
import SnapKit
import Combine
import SwiftUI

class TBCalculatorViewController: UIViewController {
    
    private let logoView = TBLogoView()
    private let resultView = TBResultView()
    private let billInputView = TBBillInputView()
    private let tipInputView = TBTipInputView()
    private let splitInputView = TBSplitInputView()
    
    private let viewModel = TBCalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView, resultView, billInputView, tipInputView, splitInputView, UIView()
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    /*
     private lazy var settingsButton: UIButton = {
     let button = UIButton(type: .system)
     button.setImage(UIImage(systemName: "gear"), for: .normal)
     button.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
     button.tintColor = ThemeColor.primaryColor
     return button
     }()
     */
    
    private func addSettingsButton() {
        let settingsButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "gear"), target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = ThemeColor.primaryColor
        layout()
        createDismissKeyboardTapGesture()
        bind()
        addSettingsButton()
    }
    
    private func bind() {
        let input = TBCalculatorViewModel.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher)
        
        let output = viewModel.transform(input: input)
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
    }
    
    private func layout() {
        view.backgroundColor = ThemeColor.backgroundColor
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.left.equalTo(view.snp.leftMargin).offset(16)
            make.right.equalTo(view.snp.rightMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        /*
         settingsButton.snp.makeConstraints { make in
         make.top.equalTo(view.snp.topMargin).offset(16)
         make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
         }
         */
    }
    
    @objc private func didTapSettingsButton() {
        let settingsViewController = TBSettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

