//
//  NetworkError.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire


struct NetworkError {
    
    var statusCode:Int = -1
    var defaultErrorMessage: String?
    var errorBody: Data?
    var response: AnyObject?
    var endpoint: String?
    var errorType: String?
    var errorMessage: String?
    
    init(status: Int = -1, error: String? = nil, data: AnyObject? = nil ) {
        statusCode = status
        defaultErrorMessage = error
        errorBody = nil
    }
    
    func printDescription() {
        guard let unwrappedBody = errorBody else {
            print("Status code:\(statusCode), \n body: ")
            return
        }
        print("Status code:\(statusCode), \n body:\(String(data: unwrappedBody, encoding: .utf8) ?? "") ")
    }
    
    func detailedError() -> String {
        guard let unwrappedBody = errorBody else {
            return "StatusCode: \(self.statusCode): No Body Endpoint: \(self.endpoint ?? "")"
        }
        return "StatusCode: \(self.statusCode): \n body: \(String(data: unwrappedBody, encoding: .utf8) ?? "") \n Endpoint: \(self.endpoint ?? "")"
    }
}

extension NetworkError {
    
    init(response: DataResponse<Any>) {
        
        self.response = response as AnyObject?
        
        if let value = response.data {
            errorBody = value
        }
        
        if let response = response.result.error {
            defaultErrorMessage = response.localizedDescription
        }
        
        if let code = response.response?.statusCode {
            statusCode = code
        }
        
        if let url = response.request?.url?.absoluteString{
            endpoint = url
        }
    }
}
