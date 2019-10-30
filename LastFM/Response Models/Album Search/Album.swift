//
//  Album.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    let name: String
    let artist: String
    
    init(with name: String, artist: String) {
        self.name = name
        self.artist = artist
    }
    
    enum AlbumCodingKeys: String, CodingKey {
        case name
        case artist
    }
    
    init(from container: KeyedDecodingContainer<AlbumCodingKeys>) throws {
        
         let name = try container.decode(String.self, forKey: .name)
         let artist = try container.decode(String.self, forKey: .artist)
        
        self.init(with: name, artist: artist)
    }
}
