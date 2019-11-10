//
//  AlbumDetailViewController.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/5/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailAlbumViewController: UIViewController {

    @IBOutlet weak var albumDetailImage: UIImageView!
    
    @IBOutlet weak var albumDetailNameLabel: UILabel!
    
    @IBOutlet weak var albumDetailArtistName: UILabel!
    
    
    // MARK: - Variables
    var presenter: DetailAlbumPresenterProtocol?
    var album: Album?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = DetailAlbumPresenter(with: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let unwrappedAlbum = album else { return }
        presenter?.set(with: unwrappedAlbum)
    }
}

extension DetailAlbumViewController: DetailAlbumViewProtocol {
    
    func updateView(with albumName: String, albumImageStringURL: String?, albumArtistName: String) {
        albumDetailArtistName.text = albumArtistName
        albumDetailNameLabel.text = albumName
        navigationItem.title = albumName
        if let stImageURL = albumImageStringURL {
            albumDetailImage.af_setImage(withURL: URL(string: stImageURL)!)
        } else {
            albumDetailImage.image = UIImage(named: "defaultImage")
        }
    }
}
