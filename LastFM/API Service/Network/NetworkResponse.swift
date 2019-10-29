//
//  NetworkResponse.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire


struct NetworkResponse {
    
    var statusCode:Int = 200
    var response: AnyObject?
    var body: Data?
    
    init(statusCode: Int = 200, response: AnyObject? = nil) {
        self.statusCode = statusCode
        self.response = response
        body = nil
    }
    
    func printDescription() {
        guard let unwrappedBody = body else {
            print("Status code:\(statusCode), \n body: ")
            return
        }
        print("Status code:\(statusCode), \n body:\(String(data: unwrappedBody, encoding: .utf8) ?? "") ")
    }
}

extension NetworkResponse {
    
    init(response: DataResponse<Any>) {
        self.response = response as AnyObject?
    
        
        if let value = response.data {
            self.body = value
        }
        
        if let code = response.response?.statusCode {
            statusCode = code
        }
    }
}
