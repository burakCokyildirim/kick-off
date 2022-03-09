//
//  TagsCollectionViewFlowLayout.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 8.03.2022.
//

import UIKit

class TagsCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        minimumLineSpacing = 8.0
        sectionInset = .zero
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
