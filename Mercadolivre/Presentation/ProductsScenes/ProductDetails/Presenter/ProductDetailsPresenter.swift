//
//  ProductDetailsPresenter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation

protocol ProductDetailsPresenter {
    func viewDidLoad()
    
    var product: Product? { get }
    var recentlyViewedProducts: [Product] { get }
}

final class DefaultProductDetailsPresenter: ProductDetailsPresenter {
    
    //MARK: - Properties
    
    var product: Product?
    var recentlyViewedProducts: [Product] = []
    private var passedProductDetailsDataModel: ProductDetailsDataModel?
    
    private let fetchProductDetailsUseCase: FetchProductDetailsUseCase
    private weak var viewController: ProductDetailsViewPresentationProtocol?
    
    //MARK: - Init
    
    init(fetchProductDetailsUseCase: FetchProductDetailsUseCase) {
        self.fetchProductDetailsUseCase = fetchProductDetailsUseCase
    }
    
    //MARK: - Functions
    
    func viewDidLoad() {
        guard let id = self.passedProductDetailsDataModel?.productID else { return }
        getProductDetails(with: id)
        getRecentlyViewedProducts()
    }
    
    // MARK: - Setters
    
    func setViewController(viewController: ProductDetailsViewPresentationProtocol) {
        self.viewController = viewController
    }
    
    func setPassedProductDataModel(dataModel: ProductDetailsDataModel) {
        self.passedProductDetailsDataModel = dataModel
    }
}

//MARK: - Private Functions

extension DefaultProductDetailsPresenter {
    
    private func getProductDetails(with id: String) {
        Loader.show()
        fetchProductDetailsUseCase.getProductDetails(id: id) { result in
            Loader.hide()
            switch result {
            case .success(let product):
                self.product = product
                self.viewController?.fillProductDetailsData()
                
            case .failure(let error):
                self.viewController?.showError(message: error.localizedDescription)
            }
        }
    }
    
    private func getRecentlyViewedProducts() {
        fetchProductDetailsUseCase.getRecentlyViewedProducts { result in
            switch result {
            case .success(let recentProduct):
                self.recentlyViewedProducts = recentProduct
                self.viewController?.reloadData()
            case .failure(let error):
                self.viewController?.showError(message: error.localizedDescription)
            }
        }
    }
}
