//
//  CollectionViewPresenterInterface.swift
//  OBSSTryout
//
//  Created by Emrah Akgül on 5.03.2021.
//

import Foundation

protocol CollectionViewPresenterInterface {
    var tag: Int! { get set }
    var numberOfSections: Int { get }
    var numberOfItems: Int { get }
}

extension CollectionViewPresenterInterface {
    var numberOfSections: Int {
        return 1
    }
}
