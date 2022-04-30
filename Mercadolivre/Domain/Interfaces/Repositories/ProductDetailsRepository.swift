//
//  ProductDetailsRepository.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation

protocol ProductDetailsRepository {
    func getProductDetails(id: String, completion: @escaping (Result<Product, Error>) -> Void)
    func fetchRecentlyViewdProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
