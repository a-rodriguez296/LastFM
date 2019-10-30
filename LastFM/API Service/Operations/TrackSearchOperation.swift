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
    var tracks:[Track]?
    
    init(with keyword: String) {
        searchKeyword = keyword
    }
    
    override func main() {
        AlamofireNetworkLayer.sharedInstance.request(SearchService.track(searchKeyword), onSuccess: {[unowned self] (response) in
            do {
                let tracksResponse = try JSONDecoder().decode(TrackSearchResults.self, from: response.body!)
                self.tracks = tracksResponse.getTracks()
            } catch {
                //Error Handling
            }
            self.state = .Finished
        }) {[unowned self] error in
            self.state = .Finished
        }
    }
}
