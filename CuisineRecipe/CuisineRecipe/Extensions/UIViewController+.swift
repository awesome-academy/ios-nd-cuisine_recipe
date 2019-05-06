//
//  UIViewController+.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

extension UIViewController {
    func setTitleNavigationBar(_ title: String) {
        self.navigationItem.title = title
    }
    
    func showError(message: String?, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showLoaddingView() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissLoaddingView() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: true, completion: nil) }
    }
    
    func showToast(message: String) {
        let sWidth = view.frame.width - 50
        let messageLabel = PaddingLabel().then {
            $0.frame = CGRect(x: (view.frame.width / 2) - (sWidth / 2),
                              y: 100,
                              width: sWidth,
                              height: 45)
            $0.text = message
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = .white
            $0.numberOfLines = 0
            $0.alpha = 1.0
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.backgroundColor = UIColor(hexString: "C0C0C0")
        }
        view.addSubview(messageLabel)
        
        UIView.animate(withDuration: 2.0,
                       delay: 1.5,
                       options: .curveEaseOut,
                       animations: {
                        messageLabel.alpha = 0.0
        }, completion: { (_) in
            messageLabel.removeFromSuperview()
        })
    }
}

final class PaddingLabel: UILabel {
    let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let height = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}
