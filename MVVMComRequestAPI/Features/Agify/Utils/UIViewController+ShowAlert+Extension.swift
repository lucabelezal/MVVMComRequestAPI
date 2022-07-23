//
//  UIViewController+ShowAlert+Extension.swift
//  MVVMComRequestAPI
//
//  Created by Lucas Nascimento on 05/07/22.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String? = nil,
        message: String? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIView {

  func dropShadow() {
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 5, height: 4)
      layer.shadowOpacity = 0.5
      layer.shadowRadius = 5
  }
}
