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
    

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
