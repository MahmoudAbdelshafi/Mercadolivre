//
//  ProductsScenesDiContainer.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

final class ProductsScenesDiContainer {
    
    // MARK: - Repositories
    
    func makeDefaultProductsRepository() -> ProductsRepository {
        DefaultProductsRepository(baseAPI: BaseAPI())
    }
    
    // MARK: - Use Cases
    
    func makeDefaultFetchProductsUseCase() -> FetchProductsUseCase {
        DefaultFetchProductsUseCase(productsRepository: makeDefaultProductsRepository())
    }
    
    //MARK: - Presenters
    
    func makeSearchProductsPresenter() -> DefaultSearchProductsPresenter {
        DefaultSearchProductsPresenter(fetchProductsUseCase: makeDefaultFetchProductsUseCase())
    }
}

// MARK: - ProductsScenesRouter Dependencies

extension ProductsScenesDiContainer: ProductsScenesRouterDependencies {
    
    func makeSearchProductsViewController() -> SearchProductsViewController {
        let presenter = makeSearchProductsPresenter()
        let viewController = SearchProductsViewController.create(with: presenter)
        presenter.setViewController(viewController: viewController)
        
        return viewController
    }
    
    func makeProductsScenesRouter(navigationController: UINavigationController) -> ProductsScenesRouter {
        ProductsScenesRouter(navigationController: navigationController, dependencies: self)
    }
}
