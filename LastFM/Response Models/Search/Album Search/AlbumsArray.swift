//
//  Albums.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct AlbumsArray: Decodable {
    
    var albumsArray:[Album] = [Album]()
    
    enum AlbumsContainerShowsCodingKeys: String, CodingKey {
        case albumsArray = "album"
    }
    
    init(from container: KeyedDecodingContainer<AlbumsContainerShowsCodingKeys>) throws {
         var responseUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .albumsArray)
        
        while !responseUnkeyedContainer.isAtEnd {
            let albumContainer = try responseUnkeyedContainer
                .nestedContainer(keyedBy: Album.AlbumCodingKeys.self)
            let album = try Album(from: albumContainer)
            albumsArray.append(album)
        }
    }
}
