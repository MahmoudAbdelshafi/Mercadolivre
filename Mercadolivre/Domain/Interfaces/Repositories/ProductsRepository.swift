//
//  ProductsRepository.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

protocol ProductsRepository {
    func searchForProducts(text: String, completion: @escaping (Result<[Product], Error>) -> Void)
}
