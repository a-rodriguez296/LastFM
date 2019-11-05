//
//  DetailArtistContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/5/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

protocol DetailArtistViewProtocol: class {
    func updateView(with artistName: String, artistImageStringURL: String?)
}

protocol DetailArtistPresenterProtocol: class {
    init(with delegate: DetailArtistViewProtocol)
    func set(with artist: Artist)
}
