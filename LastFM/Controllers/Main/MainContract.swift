//
//  MainContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/31/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

enum MainListSection: Int {
    case album = 0, artist, track
}

protocol MainViewProtocol: class {
    
}

protocol MainPresenterProtocol: class {
    
    init(with delegate: MainViewProtocol)
    func performSearch(with text: String)
    func numberOfRows(per section: MainListSection) -> Int
    func nameOfElement(at section: MainListSection, at row: Int) -> String
}

protocol MainRepositoryProtocol {
    func searchArtistsTracksAlbums(with keyword: String, onSuccess: @escaping ([Artist]?, [Album]?, [Track]?) -> ())
}
