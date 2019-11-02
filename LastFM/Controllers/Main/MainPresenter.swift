//
//  MainPresenter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/31/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {

    let secondsBetweenKeystrokes = 0.8
    let repository: MainRepositoryProtocol
    
    weak var view: MainViewProtocol?
    var timer: Timer?
    var keyword: String?
    var artistsArray: [Artist] = [Artist]()
    var albumsArray: [Album] = [Album]()
    var tracksArray: [Track] = [Track]()
    
    //This is the time we are going to wait to perform a search
    var seconds: Double
    
    required init(with delegate: MainViewProtocol) {
        view = delegate
        seconds = secondsBetweenKeystrokes
        repository = MainRepository()
    }
    
    func performSearch(with text: String) {
        
        //Start a timer each time it is in nil state
        guard let unwrappedTimer = timer else {
            initialieTimer()
            return
        }
        
        //If the timer's running, reset it and the start it again
        if unwrappedTimer.isValid {
            resetTimer()
            initialieTimer()
        }
        
        keyword = text
    }
    
    private func initialieTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MainPresenter.updateTimer), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        seconds = secondsBetweenKeystrokes
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        seconds = secondsBetweenKeystrokes
    }
    
    @objc func updateTimer() {
        
        if seconds < 0.00 {
            stopTimer()
            print("Create a request with the keyword: \(keyword ?? "")")
            if let unwrappedKeyword = keyword {
                executeRequest(with: unwrappedKeyword)
            }
        } else {
            seconds -= 0.1
        }
    }
    
    func executeRequest(with keyword: String) {
        repository.searchArtistsTracksAlbums(with: keyword) {[weak self] (artistsArray, albumsArray, tracksArray) in
            guard let unwrappedSelf = self,
            let unwrappedArtistsArray = artistsArray,
            let unwrappedAlbumsArray = albumsArray,
            let unwrappedTracksArray = tracksArray
            else { return }
            unwrappedSelf.artistsArray = unwrappedArtistsArray
            unwrappedSelf.albumsArray = unwrappedAlbumsArray
            unwrappedSelf.tracksArray = unwrappedTracksArray
            
            unwrappedSelf.view?.updateList()
        }
    }
    
    func numberOfRows(per section: MainListSection) -> Int {
        switch section {
        case .album:
            return albumsArray.count
        case .artist:
            return artistsArray.count
        case .track:
            return tracksArray.count
        }
    }
    
    func title(at section: MainListSection) -> String {
        switch section {
        case .album:
            return "Albums"
        case .artist:
            return "Artists"
        case .track:
            return "Tracks"
        }
    }
    
    func nameOfElement(at section: MainListSection, at row: Int) -> String {
        switch section {
        case .album:
            return albumsArray[row].name
        case .artist:
            return artistsArray[row].name
        case .track:
            return tracksArray[row].name
        }
    }
    
    func emptyTextInSearchBar() {
        keyword = nil
        artistsArray.removeAll()
        albumsArray.removeAll()
        tracksArray.removeAll()
        view?.updateList()
    }
    
    func numberOfSections() -> Int {
        return keyword == nil ? 0 : 3
    }
}
