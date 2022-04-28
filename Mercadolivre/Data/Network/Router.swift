//
//  Router.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Alamofire

enum Router {
    case searchProducts(text: String)
}

extension Router: TargetType {
   
    
    private var searchPath: String {
        return  "sites/MLU/search"
    }
    
    private var productPath: String {
        return  "product/"
    }
    
    private var brand: String {
        return "brand/"
    }
    
    var path: String {
        switch self {
        case .searchProducts:
            return searchPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchProducts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchProducts(let text):
            return .requestParameters(parameters: ["q": text], encoding: URLEncoding.queryString)
        }
    }
}
