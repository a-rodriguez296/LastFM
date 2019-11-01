//
//  MainContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/31/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    
}

protocol MainPresenterProtocol: class {
    
    init(with delegate: MainViewProtocol)
    
    func performSearch(with text: String)
}

protocol MainRepositoryProtocol {
    func searchArtistsTracksAlbums(with keyword: String, onSuccess: @escaping ([Artist]?, [Album]?, [Track]?) -> ())
}
