//
//  Reusable.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionReusableView: Reusable { }

extension UICollectionView {
    @discardableResult
    public func registerReusables(withClasses cellClasses: [Reusable.Type],
                                  fromNib: Bool = true) -> UICollectionView {
        for reusable in cellClasses {
            registerReusable(withClass: reusable, fromNib: fromNib)
        }
        return self
    }
    
    @discardableResult
    public func registerReusables(withNibs nibs: [String]) -> UICollectionView {
        for reusable in nibs {
            register(UINib(nibName: reusable, bundle: nil), forCellWithReuseIdentifier: reusable)
        }
        return self
    }
    
    @discardableResult
    public func registerReusable(withClass cellClass: Reusable.Type, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(withClass cellClass: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

public extension UICollectionView {
    @discardableResult
    public func registerReusableViewOfKind(_  kind: String,
                                           withClass viewClass: Reusable.Type) -> UICollectionView {
        let nib = UINib(nibName: viewClass.reuseIdentifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: viewClass.reuseIdentifier)
        return self
    }
    
    public func dequeueReusableViewOfKind<T: UICollectionReusableView>
        (_ kind: String, withClass viewClass: T.Type, for indexPath: IndexPath) -> T {
        
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.reuseIdentifier,
                                                for: indexPath)  as! T
    }
}
