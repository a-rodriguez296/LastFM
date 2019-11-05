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
    func updateList()
    func didPressEntireList(with section: MainListSection)
}

protocol MainPresenterProtocol: class {
    
    init(with delegate: MainViewProtocol)
    func performSearch(with text: String)
    func numberOfRows(per section: MainListSection) -> Int
    func element(at section: MainListSection, at row: Int) -> Element
    func title(at section: MainListSection) -> String
    func emptyTextInSearchBar()
    func numberOfSections() -> Int
}

protocol MainRepositoryProtocol {
    func searchArtistsTracksAlbums(with keyword: String, page: String, onSuccess: @escaping ([Element]?, [Element]?, [Element]?) -> ())
}

