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
        
        struct Album {
            static let methodValue = "album.search"
            static let albumKey = "album"
        }
        
    }
}
