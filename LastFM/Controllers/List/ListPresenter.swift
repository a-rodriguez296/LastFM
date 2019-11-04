//
//  ListPresenter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/3/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class ListPresenter: ListPresenterProtocol {
    
    let repository: ListRepositoryProtocol
    
    weak var view: ListViewProtocol?
    var elementsArray: [Artist] = [Artist]()
    
    required init(with delegate: ListViewProtocol, repository: ListRepositoryProtocol) {
        view = delegate
        self.repository = repository
    }
    
    func performSearch(with text: String) {
        repository.searchElements(with: text) {[weak self] array in
            guard let unwrappedSelf = self,
            let unwrappedArray = array
            else { return }
            unwrappedSelf.elementsArray = unwrappedArray
        }
    }
    
    func nameOfElement(at row: Int) -> String {
        return elementsArray[row].name
    }
    
    func numberOfRows() -> Int {
        return elementsArray.count
    }
}
