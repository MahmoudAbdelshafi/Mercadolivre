//
//  ProductsScenesDiContainer.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

final class ProductsScenesDiContainer {
    
    //MARK: - Presenters
    
    func makeSearchProductsPresenter() -> SearchProductsPresenter {
        DefaultSearchProductsPresenter()
    }
}

// MARK: - ProductsScenesRouter Dependencies

extension ProductsScenesDiContainer: ProductsScenesRouterDependencies {
    
    func makeSearchProductsViewController() -> SearchProductsViewController {
        SearchProductsViewController.create(with: makeSearchProductsPresenter())
    }
    
    func makeProductsScenesRouter(navigationController: UINavigationController) -> ProductsScenesRouter {
        return ProductsScenesRouter(navigationController: navigationController, dependencies: self)
    }
}
