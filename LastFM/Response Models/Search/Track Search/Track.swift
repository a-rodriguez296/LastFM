//
//  Track.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

struct Track: Element, Decodable {
    
    var name: String
    let artist: String
    let imagesArray: [ElementImage]
    let listeners: String
    
    init(with name: String, artist: String, array: [ElementImage], listeners: String) {
        self.name = name
        self.artist = artist
        imagesArray = array
        self.listeners = listeners
    }
    
    enum TrackCodingKeys: String, CodingKey {
        case name
        case artist
        case imagesArray = "image"
        case listeners
    }
    
    init(from container: KeyedDecodingContainer<TrackCodingKeys>) throws {
        
        let name = try container.decode(String.self, forKey: .name)
        let artist = try container.decode(String.self, forKey: .artist)
        let listeners = try container.decode(String.self, forKey: .listeners)
        
        var auxArray = [ElementImage]()
        
        var responseUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .imagesArray)
        while !responseUnkeyedContainer.isAtEnd {
            let imagesContainer = try responseUnkeyedContainer
                .nestedContainer(keyedBy: ElementImage.ElementImageCodingKeys.self)
            let image = try ElementImage(from: imagesContainer)
            auxArray.append(image)
        }
        
        self.init(with: name, artist: artist, array: auxArray, listeners: listeners)
    }
    
    func getSmallImageURL() -> String? {
        guard let image = imagesArray.first, image.stURL == "" else { return nil }
        return image.stURL
    }
    
    func getBigImageURL() -> String? {
        let imageElement = imagesArray[2]
        return imageElement.stURL
    }
}
