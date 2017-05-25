//
//  UIExtensions.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 22/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String {get}
}
extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String {get}
}
extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableView, NibLoadableView {}
extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}

extension CGSize {
    static func screenWidthWith(height: CGFloat) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height : height)
    }
}

extension UIView {
    class func loadFromNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as? T else {
            return nil
        }
        return view
    }
}

