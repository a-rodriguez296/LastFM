//
//  DetailTrackContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/6/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

protocol DetailTrackViewProtocol: class {
    func updateView(with trackName: String, trackImageStringURL: String?, trackArtistName: String, numberOfListeners: String)
}

protocol DetailTrackPresenterProtocol: class {
    init(with delegate: DetailTrackViewProtocol)
    func set(with track: Track)
}
