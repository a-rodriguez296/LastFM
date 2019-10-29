//
//  AlbumSearchService.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

enum AlbumSearchService: Service {
    case movies
    case tvShows
}

extension AlbumSearchService: URLRequestConvertible {
    static let baseURLString = Configuration.getBaseURL()
    static let serviceURL = "/discover"
    
    var method: HTTPMethod {
        switch self {
        case .movies, .tvShows:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .movies:
            return "/?method=album.search&album=believe&format=json"
        case .tvShows:
            return "/tv"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try AlbumSearchService.baseURLString.appending(AlbumSearchService.serviceURL).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}


