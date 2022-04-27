//
//  AppDIContainer.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - DIContainers of scenes
    
    func makeProductsScenesDIContainer() -> ProductsScenesDiContainer {
      return ProductsScenesDiContainer()
    }
    
}

