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
    
    func searchElements(with keyword: String, page: String, onSuccess: @escaping ([Artist]?) -> ()) {
        
        //Here the catch is to do the fetch once. Therefore, we check if the queue has running operations. If so, don't do anything, else, fetch the next page.
        if queue.operationCount == 0 {
            let operation = ArtistSearchOperation(with: keyword, page: page)
            queue.addOperation(operation)
            
            operation.completionBlock = {
                DispatchQueue.main.async {
                    onSuccess(operation.artists)
                }
            }
        }
    }
}
