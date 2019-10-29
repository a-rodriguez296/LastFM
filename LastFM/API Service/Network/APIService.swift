//
//  APIService.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

protocol Service { }

protocol APIService {
    
    func request(_ service: Service, onSuccess: @escaping (NetworkResponse) -> Void, onError: @escaping (NetworkError) -> Void)
    
}
