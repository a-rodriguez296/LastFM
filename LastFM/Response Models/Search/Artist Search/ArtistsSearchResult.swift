//
//  ArtistsSearchResult.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct ArtistSearchResults: Decodable {
    var results: ArtistMatches
    
    enum ArtistsResultsCodingKeys: String, CodingKey {
        case results
    }
    
    init(with results: ArtistMatches) {
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ArtistsResultsCodingKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: ArtistMatches.ArtistsResponseCodingKeys.self, forKey: .results)
        let results = try ArtistMatches(from: resultsContainer)
        
        self.init(with: results)
    }
    
    func getArtists() -> [Artist] {
        return results.matches.artistsArray
    }
}
