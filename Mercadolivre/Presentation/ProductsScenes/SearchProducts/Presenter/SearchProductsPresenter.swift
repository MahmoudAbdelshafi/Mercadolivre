//
//  SearchProductsPresenter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import Foundation

struct SearchProductsPresenterActions {
    let showProductDetails: (ProductDetailsDataModel) -> Void
}

protocol SearchProductsPresenter {
    func getProducts(with text: String)
    func didSelectItem(at index: Int)
    
    var products: [Product] { get }
    var errorTitle: String { get } 
}

final class DefaultSearchProductsPresenter: SearchProductsPresenter {
    
    //MARK: - Properties
    
    private let fetchProductsUseCase: FetchProductsUseCase
    private(set) weak var viewController: SearchProductsViewPresentationProtocol?
    private let actions: SearchProductsPresenterActions?
    
    var products: [Product] = []
    let errorTitle = "Error"
    
    //MARK: - Init
    
    init(fetchProductsUseCase: FetchProductsUseCase,
         actions: SearchProductsPresenterActions? = nil) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.actions = actions
    }
    
    //MARK: - Functions
    
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
    
    func didSelectItem(at index: Int) {
        let selectedProduct = products[index]
        actions?.showProductDetails(ProductDetailsDataModel(productID: selectedProduct.productID ?? ""))
    }
    
    // MARK: - Setter
    
    func setViewController(viewController: SearchProductsViewPresentationProtocol) {
        if self.viewController == nil {
            self.viewController = viewController
        } else {
           fatalError("Can't init presenter's viewController value twice")
        }
    }
}
