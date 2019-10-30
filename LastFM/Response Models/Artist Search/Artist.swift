//
//  Artist.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct Artist: Decodable {
    
    let name: String
    
    
    init(with name: String) {
        self.name = name
        
    }
    
    enum ArtistCodingKeys: String, CodingKey {
        case name
    }
    
    init(from container: KeyedDecodingContainer<ArtistCodingKeys>) throws {
        
        let name = try container.decode(String.self, forKey: .name)
        self.init(with: name)
    }
}
