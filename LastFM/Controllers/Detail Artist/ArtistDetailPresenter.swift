//
//  ArtistDetailPresenter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/5/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class ArtistDetailPresenter: DetailArtistPresenterProtocol {
    
    weak var view: DetailArtistViewProtocol?
    var artist: Artist?
    
    required init(with delegate: DetailArtistViewProtocol) {
        view = delegate
    }
    
    func set(with artist: Artist) {
        self.artist = artist
        
        view?.updateView(with: artist.name, artistImageStringURL: artist.getBigImageURL())
    }
    
    
}
