//
//  DetailAlbumPresenter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/5/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class DetailAlbumPresenter: DetailAlbumPresenterProtocol {
    
    weak var view: DetailAlbumViewProtocol?
    var album: Album?
    
    required init(with delegate: DetailAlbumViewProtocol) {
        view = delegate
    }
    
    func set(with album: Album) {
        self.album = album
        
        view?.updateView(with: album.name, albumImageStringURL: album.getBigImageURL(), albumArtistName: album.artist)
        
    }

}
