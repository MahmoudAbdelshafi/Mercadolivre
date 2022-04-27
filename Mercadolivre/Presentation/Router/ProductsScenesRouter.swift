//
//  ProductsScenesRouter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

protocol ProductsScenesRouterDependencies {
   func makeSearchProductsViewController() -> SearchProductsViewController
//    func makeProductDetailsScreenViewController(dataModel: ProductDetailsDataViewModel) -> ProductDetailsViewController
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
      //  let action = ProductsViewModelActions(showProductDetails: navigateToProductDetailsScreen(_:))
        let vc = dependencies.makeSearchProductsViewController()
        
        navigationController?.pushViewController(vc, animated: false)
        productsVC = vc
    }
    
//    private func navigateToProductDetailsScreen(_ dataModel: ProductDetailsDataViewModel) {
//        let vc = dependencies.makeProductDetailsScreenViewController(dataModel: dataModel)
//        vc.transitioningDelegate = productsVC
//        vc.modalPresentationStyle = .fullScreen
//        productsVC?.present(vc, animated: true)
//    }
}
