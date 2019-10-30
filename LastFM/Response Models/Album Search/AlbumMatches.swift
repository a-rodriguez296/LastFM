//
//  AlbumsResponse.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct AlbumMatches: Decodable {
    
    var matches: AlbumsArray
    
    enum AlbumsResponseCodingKeys: String, CodingKey {
        case matches = "albummatches"
    }
    
    init(with albumsContainer: AlbumsArray) {
        self.matches = albumsContainer
    }
    
    init(from container: KeyedDecodingContainer<AlbumsResponseCodingKeys>) throws {
        
        let albumsContainer = try container.nestedContainer(keyedBy: AlbumsArray.AlbumsContainerShowsCodingKeys.self, forKey: .matches)
        
        let matches = try AlbumsArray(from: albumsContainer)
        self.init(with: matches)
    }
    
}
