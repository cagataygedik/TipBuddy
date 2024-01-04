//
//  TBSettingsViewController.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 2.01.2024.
//

//
import SnapKit
import StoreKit
import SafariServices
import SwiftUI
import UIKit

final class TBSettingsViewController: UIViewController {
    
    private var settingsSwiftUIController: UIHostingController<TBSettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColor.backgroundColor
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(
            rootView: TBSettingsView(
                viewModel: TBSettingsViewViewModel(
                    cellViewModels: TBSettingsOption.allCases.compactMap({
                        return TBSettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    })
                )
            )
        )
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: TBSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.twitterTargetUrl {
            let twitterUrl = Strings.twitterUrl
            if UIApplication.shared.canOpenURL(twitterUrl!) {
                UIApplication.shared.open(twitterUrl!, options: [:], completionHandler: nil)
                return
            }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        } else if let url = option.rateAppTargetUrl {
            let rateAppUrl = Strings.rateAppUrl
            if UIApplication.shared.canOpenURL(rateAppUrl!) {
                UIApplication.shared.open(rateAppUrl!, options: [:], completionHandler: nil)
                return
            }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        } else if option == .developer {
            let alert = UIAlertController(title: "Made in 🇹🇷", message: "by Celil Cagatay Gedik", preferredStyle: .alert)
            alert.view.tintColor = ThemeColor.primaryColor
            let perfectButton = UIAlertAction(title: "God Bless Him", style: .default, handler: nil)
            alert.addAction(perfectButton)
            present(alert, animated: true, completion: nil)
            
        } else if let url = option.privacyPolicyTargetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
}
