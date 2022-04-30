//
//  DefaultProductsRepository.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

final class DefaultProductsRepository {
    
    private let baseAPI: BaseAPI<Router>
    
    init(baseAPI: BaseAPI<Router>) {
        self.baseAPI = baseAPI
    }
    
}

extension DefaultProductsRepository: ProductsRepository {
    
    func searchForProducts(text: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        baseAPI.fetchData(target: .searchProducts(text: text), responseClass: ProductsResponseDTO.self) { result in
            switch result {
            case .success(let products):
                completion(.success(products?.toProductsDomain() ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
