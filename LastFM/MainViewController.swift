//
//  ViewController.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/29/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       setupSearchController()

        
        ////////////////////////////////////////
        // This code is to be removed. It is just a test for NSOperationsQueue and NS Operation
        ////////////////////////////////////////
        
//        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 4
//
//        let albumsOperation = AlbumsSearchOperation(with: "Use your illution")
//        let artistOperation = ArtistSearchOperation(with: "Justin")
//        let tracksOperation = TrackSearchOperation(with: "Don't speak")
//
//        let operationsArray = [albumsOperation, artistOperation, tracksOperation]
//
//        let queueCompletionOperation = BlockOperation {}
//
//        for operation in operationsArray {
//            queueCompletionOperation.addDependency(operation)
//        }
//
//        queue.addOperations([albumsOperation, artistOperation, tracksOperation, queueCompletionOperation], waitUntilFinished: false)
//
//
//        queueCompletionOperation.completionBlock = {
//            DispatchQueue.main.async {
//                print(albumsOperation.albums ?? "")
//                print("==================")
//                print(artistOperation.artists ?? "")
//                print("==================")
//                print(tracksOperation.tracks ?? "")
//                print("==================")
//            }
//        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
}

extension MainViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        // TO-DO: Implement here
    }
}

