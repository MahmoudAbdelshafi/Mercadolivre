//
//  SearchProductsPresenter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import Foundation

protocol SearchProductsPresenter {
    func getProducts(with text: String)
    
    var products: [Product] { get }
    var errorTitle: String { get } 
}

final class DefaultSearchProductsPresenter: SearchProductsPresenter {
    
    //MARK: - Properties
    
    private let fetchProductsUseCase: FetchProductsUseCase
    private weak var viewController: SearchProductsViewPresentationProtocol?
    
    var products: [Product] = []
    let errorTitle = "Error"
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func getProducts(with text: String) {
        Loader.show()
        fetchProductsUseCase.execute(text: text) { result in
            Loader.hide()
            switch result {
            case .success(let products):
                self.products = products
                self.viewController?.reloadData()
                
            case .failure(let error):
                self.viewController?.showError(message: error.localizedDescription)
            }
     
        }
    }
    
    // MARK: - Setter
    
    func setViewController(viewController: SearchProductsViewPresentationProtocol) {
        self.viewController = viewController
    }
}
