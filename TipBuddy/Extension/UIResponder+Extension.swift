//
//  UIPresenter+Extension.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 1.01.2024.
//

import UIKit

extension UIResponder {
  var parentViewController: UIViewController? {
    return next as? UIViewController ?? next?.parentViewController
  }
}

