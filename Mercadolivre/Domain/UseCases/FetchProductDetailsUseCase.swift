//
//  FetchProductDetailsUseCase.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation

protocol FetchProductDetailsUseCase {
    func execute(id: String, completion: @escaping (Result<Product, Error>) -> Void)
}

final class DefaultFetchProductDetailsUseCase: FetchProductDetailsUseCase {
   
    //MARK: - Properties
    
    private let productDetailsRepository: ProductDetailsRepository
    
    //MARK: - Init
    
    init(productDetailsRepository: ProductDetailsRepository) {
        self.productDetailsRepository = productDetailsRepository
    }
    
    //MARK: - Methods
    
    func execute(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        productDetailsRepository.getProductDetails(id: id) { result in
            completion(result)
        }
    }

}
