//
//  ProductResponseDTO+Mapping.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

// MARK: - Products

struct ProductsResponseDTO: Decodable  {
    let results: [ProductResponseDTO]?
}

//MARK: Product

struct ProductResponseDTO: Decodable {
    let id: String?
    let title: String?
    let price: Double?
    let permalink: String?
    let thumbnail: String?
    let thumbnailID: String?
}

extension ProductsResponseDTO {
    
    func toProductsPageDomain() -> [Product] {
        var products = [Product]()
        
        for product in self.results! {
            let domainProduct = Product(title: product.title,
                                        price: "\(product.price ?? 0)",
                                        thumbnail: product.thumbnail)
            products.append(domainProduct)
        }
       return products
    }
    
}
