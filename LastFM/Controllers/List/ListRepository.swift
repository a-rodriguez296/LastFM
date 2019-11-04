//
//  ListRepository.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/3/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class ListRepository: ListRepositoryProtocol {
    
    let queue: OperationQueue
    
    init() {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
    }
    
    func searchElements(with keyword: String, page: String, elementMode: MainListSection, onSuccess: @escaping ([Element]?) -> ()) {
        
        //Here the catch is to do the fetch once. Therefore, we check if the queue has running operations. If so, don't do anything, else, fetch the next page.
        if queue.operationCount == 0 {
            let operation = createOperation(with: keyword, page: page, mode: elementMode)
            queue.addOperation(operation)
            
            operation.completionBlock = {
                DispatchQueue.main.async {
                    guard let castedOperation = operation as? OperationsProtocol else { return }
                    onSuccess(castedOperation.results)
                }
            }
        }
    }
    
    private func createOperation(with keyword: String, page: String, mode: MainListSection) -> AsyncOperation {
        
        switch mode {
        case .album:
            return AlbumsSearchOperation(with: keyword, page: page)
        case .artist:
            return ArtistSearchOperation(with: keyword, page: page)
        case .track:
            return TrackSearchOperation(with: keyword, page: page)

        }
    }
}
