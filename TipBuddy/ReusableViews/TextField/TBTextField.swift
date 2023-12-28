//
//  TBTextField.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 28.12.2023.
//

import UIKit

class TBTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        borderStyle = .none
        font = ThemeFont.demibold(ofSize: 28)
        keyboardType = .decimalPad
        clearButtonMode = .whileEditing
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        tintColor = ThemeColor.textColor
        textColor = ThemeColor.textColor
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil,action: nil),
                         doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        inputAccessoryView = toolBar
    }
    
    @objc private func doneButtonTapped() {
        endEditing(true)
    }
}
