//
//  ListContract.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/3/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

protocol ListViewProtocol: class {
    func updateList()
}

protocol ListPresenterProtocol: class {
    
    init(with delegate: ListViewProtocol)
    func performSearch(with text: String)
    func nameOfElement(at row: Int) -> String
}

protocol ListRepositoryProtocol {
    func searchElements(with keyword: String, onSuccess: @escaping ([Artist]?) -> ())
}
