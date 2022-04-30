//
//  FetchProductDetailsUseCase.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation

protocol FetchProductDetailsUseCase {
    func getProductDetails(id: String, completion: @escaping (Result<Product, Error>) -> Void)
    func getRecentlyViewedProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

final class DefaultFetchProductDetailsUseCase: FetchProductDetailsUseCase {
   
    //MARK: - Properties
    
    private let productDetailsRepository: ProductDetailsRepository
    
    //MARK: - Init
    
    init(productDetailsRepository: ProductDetailsRepository) {
        self.productDetailsRepository = productDetailsRepository
    }
    
    //MARK: - Methods
    
    func getProductDetails(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        productDetailsRepository.getProductDetails(id: id) { result in
            completion(result)
        }
    }
    
    func getRecentlyViewedProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        productDetailsRepository.fetchRecentlyViewdProducts { result in
            completion(result)
        }
    }
    
    
}
