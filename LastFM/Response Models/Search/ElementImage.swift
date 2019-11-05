//
//  ElementImage.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/4/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct ElementImage: Decodable {
    
    let stURL: String
    let size: String
    
    init(with url: String, imageSize: String) {
        stURL = url
        size = imageSize
    }
    
    enum ElementImageCodingKeys: String, CodingKey {
        case stURL = "#text"
        case size = "size"
    }
    
    init(from container: KeyedDecodingContainer<ElementImageCodingKeys>) throws {
        
        let url = try container.decode(String.self, forKey: .stURL)
        let size = try container.decode(String.self, forKey: .size)
        
        self.init(with: url, imageSize: size)
    }
}
