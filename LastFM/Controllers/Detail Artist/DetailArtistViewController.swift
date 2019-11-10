//
//  DetailArtistViewController.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/5/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailArtistViewController: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    // MARK: - Variables
    var presenter: DetailArtistPresenterProtocol?
    var artist: Artist?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = ArtistDetailPresenter(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedArtist = artist else { return }
        presenter?.set(with: unwrappedArtist)
    }
}

extension DetailArtistViewController: DetailArtistViewProtocol {
    func updateView(with artistName: String, artistImageStringURL: String?) {
        artistNameLabel.text = artistName
        navigationItem.title = artistName
        if let stImageURL = artistImageStringURL {
            artistImage.af_setImage(withURL: URL.init(string: stImageURL)!)
        } else {
            artistImage.image = UIImage(named: "defaultImage")
        }
    }
}
