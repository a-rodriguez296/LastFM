//
//  ErrorParser.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class ErrorParser {
    
    func getError(networkError: NetworkError) -> ApiError {
        guard let statusCode = HttpStatusCode(rawValue: networkError.statusCode) else { return ApiError.defaultError(message: networkError.defaultErrorMessage ?? "") }
        
        switch statusCode {
        case .Http_NoInternetConnection:
            return ApiError.connectionError()
        case .Http_TimeOutError:
            return ApiError.timeOutError()
        default:
            return ApiError.defaultError(message: networkError.defaultErrorMessage ?? "")
        }
    }
    
    func getError(error: Error) -> ApiError {
        return ApiError.defaultError(message: error.localizedDescription)
    }
}

enum ApiError: Error {
    
    case connectionError()
    
    case serverError(error: Error)
    
    case clientError(error: Error)
    
    case timeOutError()
    
    case defaultError(message: String)
    
    case JSONSerializationError(message: String)
}

