//
//  DetailTrackViewController.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/6/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit

class DetailTrackViewController: UIViewController {

    
    @IBOutlet weak var detailTrackImageView: UIImageView!
    @IBOutlet weak var detailTrackNameLabel: UILabel!
    @IBOutlet weak var detailTrackArtistLabel: UILabel!
    @IBOutlet weak var detailTrackListenersLabel: UILabel!
    
    // MARK: - Variables
    var presenter: DetailTrackPresenterProtocol?
    var track: Track?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = DetailTrackPresenter(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedTrack = track else { return }
        presenter?.set(with: unwrappedTrack)
    }
}

extension DetailTrackViewController: DetailTrackViewProtocol {
    
    func updateView(with trackName: String, trackImageStringURL: String?, trackArtistName: String, numberOfListeners: String) {
        
        detailTrackNameLabel.text = trackName
        detailTrackArtistLabel.text = trackArtistName
        detailTrackListenersLabel.text = "Number of listeners: \(numberOfListeners)"
        
        if let stImageURL = trackImageStringURL {
            detailTrackImageView.sd_setImage(with: URL(string: stImageURL), completed: nil)
        } else {
            detailTrackImageView.image = UIImage(named: "defaultImage")
        }
    }
}
