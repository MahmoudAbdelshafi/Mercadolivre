//
//  RecentlyViewedProductRealmModel.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation
import RealmSwift

class RecentlyViewedProductRealmModel: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var price: String = ""
    
    init(thumbnail: String, title: String, price: String) {
        self.thumbnail = thumbnail
        self.title = title
        self.price = price
    }
    
    required override init() {
        super.init()
    }
    
}

//MARK: - DTO

extension RecentlyViewedProductRealmModel {
    
    func toDomainProdcut() -> Product {
        let product = Product(title: self.title,
                              price: self.price,
                              thumbnail: thumbnail,
                              productID: "")
        return product
    }
}
