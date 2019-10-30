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
        AlamofireNetworkLayer.sharedInstance.request(SearchService.artist(searchKeyword), onSuccess: {[unowned self] (response) in
            do {
                let artistsResponse = try JSONDecoder().decode(ArtistSearchResults.self, from: response.body!)
                self.artists = artistsResponse.getArtists()
            } catch {
                //Error Handling
            }
            self.state = .Finished
        }) {[unowned self] error in
            self.state = .Finished
        }
    }
}
