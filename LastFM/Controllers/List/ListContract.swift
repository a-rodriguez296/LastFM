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
}

protocol ListPresenterProtocol: class {
    
    init(with delegate: ListViewProtocol, repository: ListRepositoryProtocol)
    func performSearch(with text: String)
    func nameOfElement(at row: Int) -> String
    func numberOfRows() -> Int
    func fetchNextPage(with text: String)
}

protocol ListRepositoryProtocol {
    func searchElements(with keyword: String, page: String, elementMode: ElementMode, onSuccess: @escaping ([Element]?) -> ())
}
