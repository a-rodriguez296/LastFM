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
        AlamofireNetworkLayer.sharedInstance.request(SearchService.album(searchKeyword), onSuccess: {[unowned self] (response) in
            do {
                let albumsResponse = try JSONDecoder().decode(AlbumsSearchResults.self, from: response.body!)
                self.albums = albumsResponse.getAlbums()
            } catch {
                //Error Handling
            }
            self.state = .Finished
        }) {[unowned self] error in
            self.state = .Finished
        }
    }
}
