//
//  Router.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Alamofire

enum Router {
    case searchProducts(text: String)
    case productDetails(id: String)
}

extension Router: TargetType {
   
    private var searchPath: String {
        return  "sites/MLU/search"
    }
    
    private var productDetailsPath: String {
        return  "items/"
    }
 
    var path: String {
        switch self {
        case .searchProducts:
            return searchPath
        case .productDetails(let id):
            return productDetailsPath + "\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchProducts, .productDetails:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchProducts(let text):
            return .requestParameters(parameters: ["q": text], encoding: URLEncoding.queryString)
            
        case .productDetails:
            return .requestPlain
        }
    }
}
