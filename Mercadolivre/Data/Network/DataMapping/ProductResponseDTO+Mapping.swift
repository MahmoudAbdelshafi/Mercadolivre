//
//  ProductResponseDTO+Mapping.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

// MARK: - ProductsResponseDTO

struct ProductsResponseDTO: Decodable  {
    let results: [ProductResponseDTO]?
}

//MARK: - ProductResponseDTO

struct ProductResponseDTO: Decodable {
    let id: String?
    let title: String?
    let price: Double?
    let thumbnail: String?
    let currencyID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, thumbnail
        case currencyID = "currency_id"
    }
}

extension ProductResponseDTO {
    
    func toProductDomain() -> Product {
        return Product(title: self.title,
                       price: "\(self.price ?? 0) \(self.currencyID ?? "")",
                       thumbnail: self.thumbnail,
                       productID: self.id)
    }
}

extension ProductsResponseDTO {
    
    func toProductsDomain() -> [Product] {
        var products = [Product]()
        
        for product in self.results! {
            let domainProduct = Product(title: product.title,
                                        price: "\(product.price ?? 0) \(product.currencyID ?? "")",
                                        thumbnail: product.thumbnail,
                                        productID: product.id)
            products.append(domainProduct)
        }
        return products
    }
    
}
