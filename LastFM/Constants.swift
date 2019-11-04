//
//  Constants.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct Constants {
    
    struct SearchService {
        static let methodKey = "method"
        
        static let formatKey = "format"
        static let formatValue = "json"
        
        static let limitKey = "limit"
        static let limitValue = "20"
        
        static let pageKey = "page"
        
        struct Album {
            static let methodValue = "album.search"
            static let albumKey = "album"
        }
        
        struct Artist {
            static let methodValue = "artist.search"
            static let artistKey = "artist"
        }
        
        struct Track {
            static let methodValue = "track.search"
            static let trackKey = "track"
        }
        
    }
}
