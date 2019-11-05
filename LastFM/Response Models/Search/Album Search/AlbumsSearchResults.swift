//
//  AlbumsResults.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct AlbumsSearchResults: Decodable {
    var results: AlbumMatches
    
    enum AlbumsResultsCodingKeys: String, CodingKey {
        case results
    }
    
    init(with results: AlbumMatches) {
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumsResultsCodingKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: AlbumMatches.AlbumsResponseCodingKeys.self, forKey: .results)
        let results = try AlbumMatches(from: resultsContainer)
        
        self.init(with: results)
    }
    
    func getAlbums() -> [Album] {
        return results.matches.albumsArray
    }
}
