//
//  LoaderView.swift
//  OBSSTryout
//
//  Created by Emrah Akgül on 5.03.2021.
//

import UIKit

public final class LoaderView {
    public static var shared = LoaderView()
    private var backgroundView: UIView!
    private var activityIndicatorView: UIActivityIndicatorView!
    
    private init() {
        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        backgroundView.isUserInteractionEnabled = true
        
        activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicatorView.tintColor = UIColor(white: 0.5, alpha: 1)
        activityIndicatorView.startAnimating()
    }
    
    public func startLoading(){
        self.stopLoading()
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                if !self.backgroundView.isDescendant(of: window) {
                    window.addSubview(self.backgroundView)
                    self.backgroundView.topAnchor.constraint(equalTo: window.topAnchor, constant: 0.0).isActive = true
                    self.backgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0.0).isActive = true
                    self.backgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: 0.0).isActive = true
                    self.backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0.0).isActive = true
                }
                if !self.activityIndicatorView.isDescendant(of: window) {
                    window.addSubview(self.activityIndicatorView)
                    self.activityIndicatorView.center = window.center
                }
            }
        }
    }
    
    public func stopLoading(){
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                if self.backgroundView.isDescendant(of: window) {
                    self.backgroundView.removeFromSuperview()
                }
                if self.activityIndicatorView.isDescendant(of: window) {
                    self.activityIndicatorView.removeFromSuperview()
                }
            }
        }
    }
}
