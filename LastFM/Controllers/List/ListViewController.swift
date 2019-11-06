//
//  ListViewController.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/3/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let scrollPercentageBeforeLoadNext = 0.85
    let cellIdentifier = "elementCell"
    let showArtistDetailSegueIdentifier = "artistDetailSegue"
    let showAlbumDetailSegueIdentifier = "albumDetailSegue"
    let showTrackDetailSegueIdentifier = "trackDetailSegue"
    
    // MARK: - Variables
    var presenter: ListPresenterProtocol?
    var section: MainListSection?
    var keyword: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let repository = ListRepository()
        presenter = ListPresenter(with: self, repository: repository)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ElementTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let unwrappedKeyword = keyword, let unwrappedSection = section else { return }
        navigationItem.title = "Results for \(unwrappedKeyword)"
        presenter?.keyword = unwrappedKeyword
        presenter?.elementMode = unwrappedSection
        presenter?.performSearch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showArtistDetailSegueIdentifier {
            guard let destinationVC = segue.destination as? DetailArtistViewController,
                let element = sender as? Artist
                else { return }
            destinationVC.artist = element
        }
        else if segue.identifier == showAlbumDetailSegueIdentifier {
            guard let destinationVC = segue.destination as? DetailAlbumViewController,
                let element = sender as? Album
                else { return }
            destinationVC.album = element
        } else if segue.identifier == showTrackDetailSegueIdentifier {
            guard let destinationVC = segue.destination as? DetailTrackViewController,
                let element = sender as? Track
                else { return }
            destinationVC.track = element
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ElementTableViewCell
        
        if let unwrappedPresenter = presenter {
            let element = unwrappedPresenter.element(at: indexPath.row)
            cell.update(with: element.name, imageStURL: element.getSmallImageURL())
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedPresenter = presenter
            else { return 0 }
        return unwrappedPresenter.numberOfRows()
    }
}

extension ListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxPosition = scrollView.contentInset.top + scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height
        let currentPosition = scrollView.contentOffset.y 
        
        if currentPosition / maxPosition > CGFloat(scrollPercentageBeforeLoadNext)  {
            presenter?.fetchNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let unwrappedPresenter = presenter else { return }
        unwrappedPresenter.didSelectElement(at: indexPath.row)
    }
}

extension ListViewController: ListViewProtocol {
    
    func navigateToArtist(with element: Element) {
        performSegue(withIdentifier: showArtistDetailSegueIdentifier, sender: element)
    }
    
    func navigateToAlbum(with element: Element) {
        performSegue(withIdentifier: showAlbumDetailSegueIdentifier, sender: element)
    }
    
    func navigateToTrack(with element: Element) {
        performSegue(withIdentifier: showTrackDetailSegueIdentifier, sender: element)
    }
    
    func updateList() {
        tableView.reloadData()
    }
}
