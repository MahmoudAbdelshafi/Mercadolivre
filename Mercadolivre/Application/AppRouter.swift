//
//  AppRouter.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

final class AppRouter {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let productsScenesDIContainer = appDIContainer.makeProductsScenesDIContainer()
        let flow = productsScenesDIContainer.makeProductsScenesRouter(navigationController: navigationController)
        flow.start()
    }
}
