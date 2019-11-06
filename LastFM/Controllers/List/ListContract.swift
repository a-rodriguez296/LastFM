//
//  ListContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/3/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

enum ElementMode {
    case Album
    case Artist
    case Track
}

protocol ListViewProtocol: class {
    func updateList()
    func navigateToArtist(with element: Element)
    func navigateToAlbum(with element: Element)
    func navigateToTrack(with element: Element)
}

protocol ListPresenterProtocol: class {
    
    var keyword: String? { get set }
    var elementMode: MainListSection? { get set }
    
    init(with delegate: ListViewProtocol, repository: ListRepositoryProtocol)
    func performSearch()
    func element(at row: Int) -> Element
    func numberOfRows() -> Int
    func fetchNextPage()
    func didSelectElement(at row: Int)
}

protocol ListRepositoryProtocol {
    func searchElements(with keyword: String, page: String, elementMode: MainListSection, onSuccess: @escaping ([Element]?) -> ())
}
