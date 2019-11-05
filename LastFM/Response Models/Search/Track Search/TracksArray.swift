//
//  TracksArray.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct TracksArray: Decodable {
    
    var tracksArray:[Track] = [Track]()
    
    enum TracksContainerShowsCodingKeys: String, CodingKey {
        case tracksArray = "track"
    }
    
    init(from container: KeyedDecodingContainer<TracksContainerShowsCodingKeys>) throws {
        var responseUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .tracksArray)
        
        while !responseUnkeyedContainer.isAtEnd {
            let tracksContainer = try responseUnkeyedContainer
                .nestedContainer(keyedBy: Track.TrackCodingKeys.self)
            let track = try Track(from: tracksContainer)
            tracksArray.append(track)
        }
    }
}
