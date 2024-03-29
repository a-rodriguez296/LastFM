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
    
    let headerReusableName = "Header"
    let footerReusableName = "Footer"
    let showListSegueIdentifier = "showList"
    let showArtistDetailSegueIdentifier = "artistDetailSegue"
    let showAlbumDetailSegueIdentifier = "albumDetailSegue"
    let showTrackDetailSegueIdentifier = "trackDetailSegue"
    let cellIdentifier = "elementCell"
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol?
    var searchController = UISearchController(searchResultsController: nil)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = MainPresenter(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    func setupTableView() {
        let backgroundView = Bundle.main.loadNibNamed("ListBackgroundTableView", owner: self, options: nil)?.first as! UIView
        tableView.backgroundView = backgroundView
        tableView.register(UINib.init(nibName: "MainListHeaderViewTableViewCell", bundle: nil), forCellReuseIdentifier: headerReusableName)
        tableView.register(UINib.init(nibName: "MainListFooterViewTableViewCell", bundle: nil), forCellReuseIdentifier: footerReusableName)
        tableView.register(UINib.init(nibName: "ElementTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showListSegueIdentifier {
            guard let destinationVC = segue.destination as? ListViewController,
            let section = sender as? MainListSection
                else { return }
            destinationVC.keyword = searchController.searchBar.text
            destinationVC.section = section
        }
        else if segue.identifier == showArtistDetailSegueIdentifier {
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

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let unwrappedPresenter = presenter else {
            return 0
        }
        return unwrappedPresenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedPresenter = presenter,
            let enumSection = MainListSection(rawValue: section) else { return 0 }
        return unwrappedPresenter.numberOfRows(per: enumSection)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ElementTableViewCell
        
        if let unwrappedPresenter = presenter, let enumSection = MainListSection(rawValue: indexPath.section)  {
            let element = unwrappedPresenter.element(at: enumSection, at: indexPath.row)
            cell.update(with: element.name, imageStURL: element.getSmallImageURL())
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let header = tableView.dequeueReusableCell(withIdentifier: headerReusableName) as? MainListHeaderViewTableViewCell,
            let enumSection = MainListSection(rawValue: section),
            let text = presenter?.title(at: enumSection) {
            header.setTitle(with: text)
            return header.contentView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = Bundle.main.loadNibNamed("MainListFooterView", owner: nil, options: nil)?.first as? MainListFooterView,
         let enumSection = MainListSection(rawValue: section)
            else { return nil }
        footerView.view = self
        footerView.setLabel(with: enumSection)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let unwrappedPresenter = presenter,
        let section = MainListSection(rawValue: indexPath.section)
        else { return }
        unwrappedPresenter.didSelectElement(at: section, row: indexPath.row)
    }
}

extension MainViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        //Make sure we don't query empty texts from the serverndro
        if text != "" {
            presenter?.performSearch(with: text)
        } else {
            presenter?.emptyTextInSearchBar()
        }
    }
}

extension MainViewController: MainViewProtocol {
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
    
    func didPressEntireList(with section: MainListSection) {
        performSegue(withIdentifier: showListSegueIdentifier, sender: section)
    }
}

