//
//  SearchProductsPresenter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import Foundation

protocol SearchProductsPresenter {
    func getProducts(with text: String)
}

final class DefaultSearchProductsPresenter: SearchProductsPresenter {
    
    //MARK: - Properties
    
    private let fetchProductsUseCase: FetchProductsUseCase
    private weak var viewController: SearchProductsViewPresentationProtocol?
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func getProducts(with text: String) {
        fetchProductsUseCase.execute(text: text) { result in
            print(result)
        }
    }
    
    // MARK: - Setter
    
    func setViewController(viewController: SearchProductsViewPresentationProtocol) {
        self.viewController = viewController
    }
}
