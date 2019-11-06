//
//  AlbumDetailContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/5/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation


protocol DetailAlbumViewProtocol: class {
    func updateView(with albumName: String, albumImageStringURL: String?, albumArtistName: String)
}

protocol DetailAlbumPresenterProtocol: class {
    init(with delegate: DetailAlbumViewProtocol)
    func set(with album: Album)
}
