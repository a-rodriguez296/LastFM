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
    var elementsArray: [Element] = [Element]()
    var areThereMoreElements = true
    var currentPage = 1
    var keyword: String?
    var elementMode: MainListSection?
    
    
    required init(with delegate: ListViewProtocol, repository: ListRepositoryProtocol) {
        view = delegate
        self.repository = repository
    }
    
    func performSearch() {
        if areThereMoreElements {
            guard let text = keyword, let mode = elementMode else { return }
            
            repository.searchElements(with: text, page: "\(currentPage)", elementMode: mode) {[weak self] array in
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
    
    func element(at row: Int) -> Element {
        return elementsArray[row]
    }
    
    func numberOfRows() -> Int {
        return elementsArray.count
    }
    
    func fetchNextPage() {
        performSearch()
    }
    
    func didSelectElement(at row: Int) {
        guard let mode = elementMode else { return }
        switch mode {
        case .album:
            view?.navigateToAlbum(with: elementsArray[row])
        case .artist:
            view?.navigateToArtist(with: elementsArray[row])
        case .track:
            view?.navigateToTrack(with: elementsArray[row])
        }
        
        
    }
}
