//
//  UICollectionView+Extension.swift
//  Pokemon
//
//  Created by Emrah Akgül on 7.03.2021.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = String(describing: cellType.self)
        let nib = UINib(nibName: className, bundle: Bundle(for: cellType))
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func register<T: UICollectionReusableView>(reusableViewType: T.Type, kind: String) {
        let className = String(describing: reusableViewType.self)
        let nib = UINib(nibName: className, bundle: Bundle(for: reusableViewType))
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
        register(reusableViewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type.self), for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type, kind: String,
                                                          for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: type.self), for: indexPath) as! T

    }
     
}
