//
//  FetchRecentlyViewedProductsUseCase.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 30/04/2022.
//

import Foundation

protocol FetchRecentlyViewedProductsUseCase {
    func execute(completion: @escaping (Result<[Product], Error>) -> Void)
}

final class DefaultFetchRecentlyViewedProductsUseCase: FetchRecentlyViewedProductsUseCase {
   
    //MARK: - Properties
    
    private let productDetailsRepository: ProductDetailsRepository
    
    //MARK: - Init
    
    init(productDetailsRepository: ProductDetailsRepository) {
        self.productDetailsRepository = productDetailsRepository
    }
    
    //MARK: - Methods
    
    func execute(completion: @escaping (Result<[Product], Error>) -> Void) {
        productDetailsRepository.fetchRecentlyViewdProducts { result in
            completion(result)
        }
    }
}
