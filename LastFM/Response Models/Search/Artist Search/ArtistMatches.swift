//
//  ArtistMatches.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct ArtistMatches: Decodable {
    
    var matches: ArtistsArray
    
    enum ArtistsResponseCodingKeys: String, CodingKey {
        case matches = "artistmatches"
    }
    
    init(with artistContainer: ArtistsArray) {
        self.matches = artistContainer
    }
    
    init(from container: KeyedDecodingContainer<ArtistsResponseCodingKeys>) throws {
        
        let artistContainer = try container.nestedContainer(keyedBy: ArtistsArray.ArtistsContainerShowsCodingKeys.self, forKey: .matches)
        
        let matches = try ArtistsArray(from: artistContainer)
        self.init(with: matches)
    }
    
}
