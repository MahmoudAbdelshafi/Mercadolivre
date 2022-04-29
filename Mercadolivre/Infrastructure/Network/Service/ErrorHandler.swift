//
//  ErrorHandler.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import Foundation

enum ErrorHandler: Error {
    
    case general
    case checkStatus(code : Int)
    case parsing
    case backEndErrorResponse(message: String)
    
    var errorMessage : String {
        switch self {
        case .backEndErrorResponse(let message):
            return message
        case .general:
            return "Something went wrong please try again."
        case .checkStatus(let code):
            if (400..<499).contains(code) {
                return "'\(code) error message."
            }
            if (500..<599).contains(code) {
                return "Server Error."
            }
            if (200..<300).contains(code) {
                return "Success."
            }
        case .parsing:
            return "Error Parsing Data."
        }
        return "Network Error."
    }
}
