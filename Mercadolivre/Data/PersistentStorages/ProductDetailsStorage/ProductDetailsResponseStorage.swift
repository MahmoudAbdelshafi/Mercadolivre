//
//  ProductDetailsResponseStorage.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 30/04/2022.
//

import Foundation

protocol ProductDetailsResponseStorage {
    func getRecentlyViewd(completion: @escaping (Result<[RecentlyViewedProductRealmModel], Error>) -> Void)
    func save(response: ProductResponseDTO, completion: @escaping (Result<[RecentlyViewedProductRealmModel], Error>) -> Void)
}
