//
//  RealmProductDetailsResponseStorage.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation


final class RealmProductDetailsResponseStorage {
    
}

extension RealmProductDetailsResponseStorage: ProductDetailsResponseStorage {
    
    func getRecentlyViewd(completion: @escaping (Result<[RecentlyViewedProductRealmModel], Error>) -> Void) {
        RealmStorageManager.getObjects(RecentlyViewedProductRealmModel.self) { recentProducts in
            let sortedProducts = sortRecentlyViewedProducts(products: recentProducts)
            completion(.success(sortedProducts))
            
            if recentProducts.count == 5 {
               guard let realmObjectToDelete = sortedProducts.last else { return }
                RealmStorageManager.deleteObject(realmObjectToDelete)
            }
        }
    }
    
    private func sortRecentlyViewedProducts(products: [RecentlyViewedProductRealmModel]) -> [RecentlyViewedProductRealmModel] {
        products.sorted { p1, p2 in p1.date.compare(p2.date) == .orderedDescending }
    }
    
    func save(response: ProductResponseDTO, completion: @escaping (Result<[RecentlyViewedProductRealmModel], Error>) -> Void) {
        let realmModel = RecentlyViewedProductRealmModel(thumbnail: response.thumbnail ?? "",
                                                         title: response.title ?? "",
                                                         price: "\(response.price ?? 0) \(response.currencyID ?? "")")
        RealmStorageManager.setObject(realmModel)
    }
}

