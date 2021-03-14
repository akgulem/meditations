//
//  BaseInteractorOutput.swift
//  OBSSTryout
//
//  Created by Emrah Akgül on 5.03.2021.
//

import Foundation

protocol BaseInteractorOutput: class {
    func setLoading(shouldLoad: Bool)
}

extension BaseInteractorOutput {
    func setLoading(shouldLoad: Bool) {
        shouldLoad ? LoaderView.shared.startLoading() : LoaderView.shared.stopLoading()
    }
}
