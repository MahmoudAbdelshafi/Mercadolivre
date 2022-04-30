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
    
    func makeDefaultFetchProductDetailsUseCase() -> FetchProductDetailsUseCase {
        DefaultFetchProductDetailsUseCase(productDetailsRepository:DefaultProductDetailsRepository(baseAPI: BaseAPI()))
    }
    
    //MARK: - Presenters
    
    func makeSearchProductsPresenter(actions: SearchProductsPresenterActions?) -> DefaultSearchProductsPresenter {
        DefaultSearchProductsPresenter(fetchProductsUseCase: makeDefaultFetchProductsUseCase(), actions: actions)
    }
    
    func makeProductDetailsPresenter() -> DefaultProductDetailsPresenter {
        DefaultProductDetailsPresenter(fetchProductDetailsUseCase: makeDefaultFetchProductDetailsUseCase())
    }
}

// MARK: - ProductsScenesRouter Dependencies

extension ProductsScenesDiContainer: ProductsScenesRouterDependencies {
    
    func makeSearchProductsViewController(actions: SearchProductsPresenterActions) -> SearchProductsViewController {
        let presenter = makeSearchProductsPresenter(actions: actions)
        let viewController = SearchProductsViewController.create(with: presenter)
        presenter.setViewController(viewController: viewController)
        
        return viewController
    }
    
    func makeProductsScenesRouter(navigationController: UINavigationController) -> ProductsScenesRouter {
        ProductsScenesRouter(navigationController: navigationController, dependencies: self)
    }
    
    func makeProductDetailsScreenViewController(dataModel: ProductDetailsDataModel) -> ProductDetailsViewController {
        let presenter = makeProductDetailsPresenter()
        let viewController = ProductDetailsViewController.create(with: presenter)
        presenter.setViewController(viewController: viewController)
        presenter.setPassedProductDataModel(dataModel: dataModel)
        return viewController
    }
    
}
