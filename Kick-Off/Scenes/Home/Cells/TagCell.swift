//
//  TagCell.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 8.03.2022.
//

import UIKit

class TagCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!

    func setup(with tagModel: ContentsModel.Tag) {
        tagLabel.text = tagModel.name
        tagLabel.textColor = UIColor(hexString: tagModel.color)
        contentView.backgroundColor = UIColor(hexString: tagModel.backgroundColor)
    }
}
