//
//  FetchProductsUseCase.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

protocol FetchProductsUseCase {
    func execute(text: String, completion: @escaping (Result<[Product], Error>) -> Void)
}

final class DefaultFetchProductsUseCase: FetchProductsUseCase {
    
    //MARK: - Properties
    
    private let productsRepository: ProductsRepository
    
    //MARK: - Init
    
    init(productsRepository: ProductsRepository) {
        self.productsRepository = productsRepository
    }
    
    //MARK: - Methods
    
    func execute(text: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        productsRepository.searchForProducts(text: text) { result in
            completion(result)
        }
    }
    
}
