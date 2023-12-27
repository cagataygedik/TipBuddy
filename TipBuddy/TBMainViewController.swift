//
//  ViewController.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 25.12.2023.
//

import UIKit
import SnapKit

class TBMainViewController: UIViewController {
    
    private let logoView = TBLogoView()
    private let resultView = TBResultView()
    private let billInputView = TBBillInputView()
    private let tipInputView = TBTipInputView()
    private let splitInputView = TBSplitInputView()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView, resultView, billInputView, tipInputView, splitInputView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
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
    }
}

