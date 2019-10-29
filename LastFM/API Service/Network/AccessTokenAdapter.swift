//
//  AccessTokenAdapter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestAdapter {
    
    var apiKeyParameter: Parameters = [String:String]()
    
    init(apiKey: String) {
        apiKeyParameter["api_key"] = apiKey
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("http://ws.audioscrobbler.com/2.0/") {
            return try URLEncoding.default.encode(urlRequest, with: apiKeyParameter)
        }
        return urlRequest
    }
}
