//
//  ArtistSearchOperation.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/30/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class ArtistSearchOperation: AsyncOperation {
    
    let searchKeyword: String
    var artists:[Artist]?
    
    init(with keyword: String) {
        searchKeyword = keyword
    }
    
    override func main() {
        if !isCancelled {
            AlamofireNetworkLayer.sharedInstance.request(SearchService.artist(searchKeyword), onSuccess: {[weak self] (response) in
                guard let unwrappedSelf = self else { return }
                do {
                    if !unwrappedSelf.isCancelled {
                        let artistsResponse = try JSONDecoder().decode(ArtistSearchResults.self, from: response.body!)
                        unwrappedSelf.artists = artistsResponse.getArtists()
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
