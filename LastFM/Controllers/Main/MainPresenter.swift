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
        repository.searchArtistsTracksAlbums(with: keyword) { (artistsArray, albumsArray, tracksArray) in
            print("hola")
        }
    }
}
