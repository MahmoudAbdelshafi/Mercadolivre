//
//  ProductsScenesRouter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

protocol ProductsScenesRouterDependencies {
    func makeSearchProductsViewController(actions: SearchProductsPresenterActions) -> SearchProductsViewController
    func makeProductDetailsScreenViewController(dataModel: ProductDetailsDataModel) -> ProductDetailsViewController
}

final class ProductsScenesRouter {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: ProductsScenesRouterDependencies
    
    private weak var productsVC: SearchProductsViewController?
    
    init(navigationController: UINavigationController,
         dependencies: ProductsScenesRouterDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let action = SearchProductsPresenterActions(showProductDetails: navigateToProductDetailsScreen(_:))
        let vc = dependencies.makeSearchProductsViewController(actions: action)
        
        navigationController?.pushViewController(vc, animated: false)
        productsVC = vc
    }
    
    private func navigateToProductDetailsScreen(_ dataModel: ProductDetailsDataModel) {
        let vc = dependencies.makeProductDetailsScreenViewController(dataModel: dataModel)
        productsVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
