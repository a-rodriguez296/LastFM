//
//  Artist.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct Artist: Element, Decodable {
    
    var name: String
    let imagesArray: [ElementImage]
    
    init(with name: String, array: [ElementImage]) {
        self.name = name
        self.imagesArray = array
        
    }
    
    enum ArtistCodingKeys: String, CodingKey {
        case name
        case imagesArray = "image"
    }
    
    init(from container: KeyedDecodingContainer<ArtistCodingKeys>) throws {
        
        let name = try container.decode(String.self, forKey: .name)
        
        var auxArray = [ElementImage]()
        
        var responseUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .imagesArray)
        while !responseUnkeyedContainer.isAtEnd {
            let imagesContainer = try responseUnkeyedContainer
                .nestedContainer(keyedBy: ElementImage.ElementImageCodingKeys.self)
            let image = try ElementImage(from: imagesContainer)
            auxArray.append(image)
        }
        
        self.init(with: name, array: auxArray)
    }
    
    func getSmallImageURL() -> String? {
        guard let image = imagesArray.first, image.stURL != "" else { return nil }
        return image.stURL
    }
    
    func getBigImageURL() -> String? {
        let imageElement = imagesArray[2]
        return imageElement.stURL.isEmpty ? nil : imageElement.stURL
    }
}
