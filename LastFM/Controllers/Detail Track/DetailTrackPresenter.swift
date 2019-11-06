//
//  DetailTrackPresenter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/6/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class DetailTrackPresenter: DetailTrackPresenterProtocol {
    
    weak var view: DetailTrackViewProtocol?
    var track: Track?
    
    required init(with delegate: DetailTrackViewProtocol) {
        view = delegate
    }
    
    func set(with track: Track) {
        self.track = track
        view?.updateView(with: track.name, trackImageStringURL: track.getBigImageURL(), trackArtistName: track.artist, numberOfListeners: track.listeners)
    }   
}
