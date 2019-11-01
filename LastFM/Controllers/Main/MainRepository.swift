//
//  MainRepository.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/31/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class MainRepository: MainRepositoryProtocol {
    
    
    func searchArtistsTracksAlbums(with keyword: String, onSuccess: @escaping ([Artist]?, [Album]?, [Track]?) -> ()) {
        
        //Create a queue for the 4 operations. The 4th operation is just a stub operation to know when is it that the others have finished.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        
        let albumsOperation = AlbumsSearchOperation(with: keyword)
        let artistOperation = ArtistSearchOperation(with: keyword)
        let tracksOperation = TrackSearchOperation(with: keyword)
        
        let operationsArray = [albumsOperation, artistOperation, tracksOperation]
        
        let completionOperation = BlockOperation {}
        
        for operation in operationsArray {
            completionOperation.addDependency(operation)
        }
        
        queue.addOperations([albumsOperation, artistOperation, tracksOperation, completionOperation], waitUntilFinished: false)
        
        
        completionOperation.completionBlock = {
            DispatchQueue.main.async {
                onSuccess(artistOperation.artists, albumsOperation.albums, tracksOperation.tracks)
            }
        }
    }
 
}
