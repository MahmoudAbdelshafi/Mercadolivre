//
//  ProductResponseDTO+Mapping.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

// MARK: - ProductsResponseDTO

struct ProductsResponseDTO: Decodable  {
    let results: [ProductResponse]?
}

//MARK: ProductResponse

struct ProductResponse: Decodable {
    let id: String?
    let title: String?
    let price: Double?
    let permalink: String?
    let thumbnail: String?
    let thumbnailID: String?
    let currencyID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, permalink, thumbnail, thumbnailID
        case currencyID = "currency_id"
    }
}

extension ProductsResponseDTO {
    
    func toProductsPageDomain() -> [Product] {
        var products = [Product]()
        
        for product in self.results! {
            let domainProduct = Product(title: product.title,
                                        price: "\(product.price ?? 0) \(product.currencyID ?? "")",
                                        thumbnail: product.thumbnail)
            products.append(domainProduct)
        }
        return products
    }
    
}
