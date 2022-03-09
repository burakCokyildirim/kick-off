//
//  UIView+RoundCorners.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 8.03.2022.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: CACornerMask? = nil, cornerRadius: CGFloat = 6.0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        if let corners = corners {
            layer.maskedCorners = corners
        }
    }
}
