//
//  TrackSearchOperation.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/30/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class TrackSearchOperation: AsyncOperation {
    
    let searchKeyword: String
    let page: String
    var tracks:[Track]?
    
    init(with keyword: String, page: String) {
        searchKeyword = keyword
        self.page = page
    }
    
    override func main() {
        if !isCancelled {
            AlamofireNetworkLayer.sharedInstance.request(SearchService.track(searchKeyword, page), onSuccess: {[weak self] (response) in
                guard let unwrappedSelf = self else { return }
                
                do {
                    if !unwrappedSelf.isCancelled {
                        let tracksResponse = try JSONDecoder().decode(TrackSearchResults.self, from: response.body!)
                        unwrappedSelf.tracks = tracksResponse.getTracks()
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
