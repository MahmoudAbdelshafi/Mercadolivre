//
//  DefaultProductDetailsRepository.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation

final class DefaultProductDetailsRepository {
    
    private let baseAPI: BaseAPI<Router>
    private let cache: ProductDetailsResponseStorage
    
    init(baseAPI: BaseAPI<Router>,
         cashe: ProductDetailsResponseStorage = RealmProductDetailsResponseStorage()) {
        self.baseAPI = baseAPI
        self.cache = cashe
    }
    
}

extension DefaultProductDetailsRepository: ProductDetailsRepository {
    
    func getProductDetails(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        baseAPI.fetchData(target: .productDetails(id: id), responseClass: ProductResponseDTO.self) { result in
            switch result {
            case .success(let product):
                guard let domainProduct = product?.toProductDomain() else { return }
                completion(.success(domainProduct))
                guard let product = product else { return }
                self.saveRecentlyViewdProduct(response: product)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchRecentlyViewdProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        cache.getRecentlyViewd { result in
            switch result {
            case .success(let recentProducts):
                var products = [Product]()
                _ = recentProducts.map { products.append( $0.toDomainProdcut()) }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveRecentlyViewdProduct(response: ProductResponseDTO) {
        cache.save(response: response) { _ in }
    }
    
}
