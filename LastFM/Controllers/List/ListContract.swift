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
    
    var keyword: String? { get set }
    var elementMode: MainListSection? { get set }
    
    init(with delegate: ListViewProtocol, repository: ListRepositoryProtocol)
    func performSearch()
    func nameOfElement(at row: Int) -> String
    func numberOfRows() -> Int
    func fetchNextPage()
}

protocol ListRepositoryProtocol {
    func searchElements(with keyword: String, page: String, elementMode: MainListSection, onSuccess: @escaping ([Element]?) -> ())
}
