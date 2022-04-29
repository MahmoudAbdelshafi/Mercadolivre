//
//  BaseAPI.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation
import Alamofire

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion:@escaping (Result<M?, ErrorHandler>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        #if DEBUG
        print("headers  ",headers)
        #endif
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseData { (response) in
            #if DEBUG
            print("urlRequest ",response.request?.urlRequest as Any)
            print("response ",response)
            #endif
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(.backEndErrorResponse(message: response.error?.localizedDescription ?? "")))
                return
            }
            if statusCode == 200 {
    
                guard let data = response.data else {
                    completion(.failure(.parsing))
                    return
                }
                
                guard let responseObj = try? JSONDecoder().decode(M.self, from: data) else {
                    completion(.failure(.parsing))
                    return
                }
                completion(.success(responseObj))
            } else if (400..<599).contains(statusCode) {
                guard (try? response.result.get()) != nil else {
                    completion(.failure(.checkStatus(code: statusCode)))
                    return
                }
            }
            else {
                completion(.failure(.checkStatus(code: statusCode)))
            }
        }
    }
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
