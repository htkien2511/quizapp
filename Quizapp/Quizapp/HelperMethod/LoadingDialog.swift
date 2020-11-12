//
//  LoadingDialog.swift
//  AppCheckInByQRCode
//
//  Created by Hoang Trong Kien on 7/10/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class LoadingDialog {
  static func showLoadingDialog(_ baseViewController: UIViewController) {
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.medium // Style.gray
    loadingIndicator.startAnimating();

    alert.view.addSubview(loadingIndicator)
    baseViewController.present(alert, animated: true, completion: nil)
  }
}
