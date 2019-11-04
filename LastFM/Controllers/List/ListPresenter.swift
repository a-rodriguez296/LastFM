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
    var areThereMoreElements = true
    var currentPage = 1
    
    required init(with delegate: ListViewProtocol, repository: ListRepositoryProtocol) {
        view = delegate
        self.repository = repository
    }
    
    func performSearch(with text: String) {
        if areThereMoreElements {
            repository.searchElements(with: text, page: "\(currentPage)") {[weak self] array in
                guard let unwrappedSelf = self,
                    let unwrappedArray = array
                    else { return }
                if !unwrappedArray.isEmpty {
                    unwrappedSelf.elementsArray.append(contentsOf: unwrappedArray)
                    unwrappedSelf.view?.updateList()
                    unwrappedSelf.currentPage += 1
                } else {
                    unwrappedSelf.areThereMoreElements = false
                }
            }
        }
    }
    
    func nameOfElement(at row: Int) -> String {
        return elementsArray[row].name
    }
    
    func numberOfRows() -> Int {
        return elementsArray.count
    }
    
    func fetchNextPage(with text: String) {
        performSearch(with: text)
    }
}
