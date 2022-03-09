//
//  ContentCell.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 8.03.2022.
//

import UIKit
import Kingfisher

class ContentCell: UITableViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    var tags: [ContentsModel.Tag] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUI()
        configureCollectionView()
    }

    func setup(with model: ContentsModel.Content) {
        headlineLabel.text = model.headline
        summaryLabel.text = model.summary

        if let coverImageUrl = model.cover?.url {
            coverImageView.kf.setImage(with: URL(string: coverImageUrl))
        }

        if let tags = model.tags {
            self.tags = tags
            tagsCollectionView.reloadData()
            tagsCollectionView.layoutSubviews()
            collectionViewHeightConstraint.constant = tagsCollectionView.contentSize.height
        }
    }

    private func configureUI() {
        selectionStyle = .none
        containerView.roundCorners(cornerRadius: 8.0)
        shadowView.addingShadow(size: .init(width: 0.0, height: 3.0), radius: 24, opacity: 0.3)
    }

    private func configureCollectionView() {
        let flowLayout =  TagsCollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagsCollectionView.collectionViewLayout = flowLayout
        tagsCollectionView.dataSource = self
        tagsCollectionView.register(
            UINib(nibName: TagCell.className, bundle: .main),
            forCellWithReuseIdentifier: TagCell.className)
    }
}

extension ContentCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCell.className, for: indexPath) as? TagCell
        let tagModel = tags[indexPath.row]
        cell?.setup(with: tagModel)
        return cell ?? UICollectionViewCell()
    }
}
