//
//  AlamofireNetwokrLayer.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 9/24/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

public struct AlamofireNetworkLayer: APIService {
    
    static let sharedInstance: AlamofireNetworkLayer = AlamofireNetworkLayer()
    
    let baseURLString = Configuration.getBaseURL()
    
    let sessionManager:SessionManager = {
        let sm = SessionManager()
        
        //This token should be encrypted using git-crypt or a similar tool. For ease of the project I kept the token as plain text, however this token should be encrypted.
        let adapter = AccessTokenAdapter.init(apiKey: "65eef1c48fea71f703b327b8b230f491")
        sm.adapter = adapter
        return sm
    }()
    
    
    
    
    func request(_ service: Service, onSuccess: @escaping (NetworkResponse) -> Void, onError: @escaping (NetworkError) -> Void) {
        
        guard let service = service as? URLRequestConvertible else {
            return
        }
        
        sessionManager.request(service).validate().responseJSON { response in
            switch response.result {
            case .success:
                onSuccess(NetworkResponse(response: response))
            case .failure:
                onError(NetworkError(response: response))
            }
        }
    }
}
