//
//  TrackSearchResults.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct TrackSearchResults: Decodable {
    var results: TrackMatches
    
    enum TracksResultsCodingKeys: String, CodingKey {
        case results
    }
    
    init(with results: TrackMatches) {
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: TracksResultsCodingKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: TrackMatches.TracksResponseCodingKeys.self, forKey: .results)
        let results = try TrackMatches(from: resultsContainer)
        
        self.init(with: results)
    }
    
    func getTracks() -> [Track] {
        return results.matches.tracksArray
    }
}
