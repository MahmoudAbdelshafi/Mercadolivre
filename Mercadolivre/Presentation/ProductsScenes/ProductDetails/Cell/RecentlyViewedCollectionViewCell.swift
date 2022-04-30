//
//  RecentlyViewedCollectionViewCell.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 30/04/2022.
//

import UIKit

class RecentlyViewedCollectionViewCell: UICollectionViewCell, CellBaseProtocol {

    static let reusableIdentifier = String(describing: RecentlyViewedCollectionViewCell.self)
    static let xibName = String(describing: RecentlyViewedCollectionViewCell.self)
    
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(product: Product) {
        cellImage.loadWebImageWithUrl(imageUrl: product.thumbnail ?? "")
        titleLabel.text = product.title
        priceLabel.text = product.price
    }

}
