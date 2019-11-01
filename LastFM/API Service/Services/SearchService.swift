//
//  AlbumSearchService.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import Alamofire

enum SearchService: Service {
    case album(String)
    case artist(String)
    case track(String)
    
}

extension SearchService: URLRequestConvertible {
    static let baseURLString = Configuration.getBaseURL()
    static let serviceURL = ""
    
    var method: HTTPMethod {
        switch self {
        case .album, .artist, .track:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .album, .artist, .track:
            return ""
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .album(let keyword):
            return [Constants.SearchService.methodKey: Constants.SearchService.Album.methodValue,
                    Constants.SearchService.formatKey: Constants.SearchService.formatValue,
                    Constants.SearchService.limitKey: Constants.SearchService.limitValue,
                    Constants.SearchService.Album.albumKey: keyword]
        case .artist(let keyword):
            return [Constants.SearchService.methodKey: Constants.SearchService.Artist.methodValue,
                    Constants.SearchService.formatKey: Constants.SearchService.formatValue,
                    Constants.SearchService.limitKey: Constants.SearchService.limitValue,
                    Constants.SearchService.Artist.artistKey: keyword]
        case .track(let keyword):
            return [Constants.SearchService.methodKey: Constants.SearchService.Track.methodValue,
                    Constants.SearchService.formatKey: Constants.SearchService.formatValue,
                    Constants.SearchService.limitKey: Constants.SearchService.limitValue,
                    Constants.SearchService.Track.trackKey: keyword]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try SearchService.baseURLString.appending(SearchService.serviceURL).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}


