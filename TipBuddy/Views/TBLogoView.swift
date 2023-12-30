//
//  TBLogoView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 27.12.2023.
//

import UIKit
import SnapKit

class TBLogoView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(named: "image"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        button.tintColor = ThemeColor.primaryColor
        return button
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "TIP", attributes: [.font: ThemeFont.bold(ofSize: 24)])
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel = TBLabel(text: "Buddy", font: ThemeFont.demibold(ofSize: 20),textAlignment: .left)
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stackView.axis = .vertical
        stackView.spacing = -4
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, verticalStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSettingsButton() {
    }
    
    private func layout() {
        addSubview(horizontalStackView)
        addSubview(settingsButton)
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(horizontalStackView)
            make.trailing.equalToSuperview()
        }
    }
}
