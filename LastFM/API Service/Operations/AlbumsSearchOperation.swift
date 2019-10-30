//
//  AlbumsSearchOperation.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/30/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class AlbumsSearchOperation: AsyncOperation {
    
    let searchKeyword: String
    var albums:[Album]?
    
    init(with keyword: String) {
        searchKeyword = keyword
    }
    
    override func main() {
        if !isCancelled {
            AlamofireNetworkLayer.sharedInstance.request(SearchService.album(searchKeyword), onSuccess: {[weak self] (response) in
                guard let unwrappedSelf = self else { return }
                do {
                    if !unwrappedSelf.isCancelled {
                        let albumsResponse = try JSONDecoder().decode(AlbumsSearchResults.self, from: response.body!)
                        unwrappedSelf.albums = albumsResponse.getAlbums()
                    }
                } catch {
                    //Error Handling
                }
                unwrappedSelf.state = .Finished
            }) {[weak self] error in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.state = .Finished
            }
        }
    }
}
