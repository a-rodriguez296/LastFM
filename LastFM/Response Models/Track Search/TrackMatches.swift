//
//  TrackMatches.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct TrackMatches: Decodable {
    
    var matches: TracksArray
    
    enum TracksResponseCodingKeys: String, CodingKey {
        case matches = "trackmatches"
    }
    
    init(with trackContainer: TracksArray) {
        self.matches = trackContainer
    }
    
    init(from container: KeyedDecodingContainer<TracksResponseCodingKeys>) throws {
        
        let trackContainer = try container.nestedContainer(keyedBy: TracksArray.TracksContainerShowsCodingKeys.self, forKey: .matches)
        
        let matches = try TracksArray(from: trackContainer)
        self.init(with: matches)
    }
    
}
