//
//  UIViewController+Extension.swift
//  Pokemon
//
//  Created by Emrah Akgül on 7.03.2021.
//

import UIKit

public extension UIViewController {
    
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }
}
