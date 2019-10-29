//
//  HttpStatusCode.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

public enum HttpStatusCode: Int {
    case Http_NoInternetConnection = -1
    
    case Http200_OK = 200
    case Http201_Created = 201
    case Http202_Accepted = 202
    
    
    case Http400_BadRequest = 400
    case Http401_Unauthorized = 401
    case Http403_Forbidden = 403
    case Http404_NotFound = 404
    
    
    case Http500_InternalServerError = 500
    case Http501_NotImplemented = 501
    
    
    case Http_TimeOutError = -1001
    
    public var isSuccess: Bool {
        return self.rawValue >= 200 && self.rawValue <= 299
    }
    
    public var isClientError: Bool {
        return self.rawValue >= 400 && self.rawValue <= 499
    }
    
    public var isServerError: Bool {
        return self.rawValue >= 500 && self.rawValue <= 599
    }
}
