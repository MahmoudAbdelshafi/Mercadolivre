//
//  ProductsTableViewCell.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import UIKit

class ProductsTableViewCell: UITableViewCell, CellBaseProtocol {
    
    static let reusableIdentifier = String(describing: ProductsTableViewCell.self)
    static let xibName = String(describing: ProductsTableViewCell.self)
    
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
}
