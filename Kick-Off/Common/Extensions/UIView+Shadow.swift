//
//  UIView+Shadow.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 8.03.2022.
//

import UIKit

extension UIView {
    func addingShadow(size: CGSize, radius: CGFloat, opacity: Float) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = size
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
