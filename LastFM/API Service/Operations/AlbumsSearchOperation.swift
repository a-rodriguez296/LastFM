//
//  AlbumsSearchOperation.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/30/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class AlbumsSearchOperation: AsyncOperation, OperationsProtocol {
    
    let searchKeyword: String
    let page: String
    var results:[Element]?
    
    init(with keyword: String, page: String) {
        searchKeyword = keyword
        self.page = page
    }
    
    override func main() {
        if !isCancelled {
            AlamofireNetworkLayer.sharedInstance.request(SearchService.album(searchKeyword, page), onSuccess: {[weak self] (response) in
                guard let unwrappedSelf = self else { return }
                do {
                    if !unwrappedSelf.isCancelled {
                        let albumsResponse = try JSONDecoder().decode(AlbumsSearchResults.self, from: response.body!)
                        unwrappedSelf.results = albumsResponse.getAlbums()
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
