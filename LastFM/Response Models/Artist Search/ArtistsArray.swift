//
//  ArtistsArray.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct ArtistsArray: Decodable {
    
    var artistsArray:[Artist] = [Artist]()
    
    enum ArtistsContainerShowsCodingKeys: String, CodingKey {
        case artistsArray = "artist"
    }
    
    init(from container: KeyedDecodingContainer<ArtistsContainerShowsCodingKeys>) throws {
        var responseUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .artistsArray)
        
        while !responseUnkeyedContainer.isAtEnd {
            let artistContainer = try responseUnkeyedContainer
                .nestedContainer(keyedBy: Artist.ArtistCodingKeys.self)
            let artist = try Artist(from: artistContainer)
            artistsArray.append(artist)
        }
    }
}
