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

final class TBCalculatorViewController: UIViewController {
    
    private let resultView = TBResultView()
    private let billInputView = TBBillInputView()
    private let tipInputView = TBTipInputView()
    private let splitInputView = TBSplitInputView()
    
    private let viewModel = TBCalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            resultView, billInputView, tipInputView, splitInputView, UIView()
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        layout()
        createDismissKeyboardTapGesture()
        bind()
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
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = ThemeColor.primaryColor
        setupNavigationBarTitle()
        addResetButton()
        addSettingsButton()
    }
    
    private func setupNavigationBarTitle() {
        let imageView = UIImageView(image: UIImage(named: "image"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func addResetButton() {
        let resetButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "arrow.clockwise"), target: self, action: #selector(didTapResetButton))
        navigationItem.leftBarButtonItem = resetButton
    }
    
    private func addSettingsButton() {
        let settingsButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "gear"), target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func didTapResetButton() {
        billInputView.reset()
        tipInputView.reset()
        splitInputView.reset()
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
