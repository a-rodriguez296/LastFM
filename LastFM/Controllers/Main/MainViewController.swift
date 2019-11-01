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
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        let backgroundView = Bundle.main.loadNibNamed("ListBackgroundTableView", owner: self, options: nil)?.first as! UIView
        tableView.backgroundView = backgroundView
        
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedPresenter = presenter,
            let enumSection = MainListSection(rawValue: section) else { return 0 }
        return unwrappedPresenter.numberOfRows(per: enumSection)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        if let unwrappedPresenter = presenter, let enumSection = MainListSection(rawValue: indexPath.section)  {
            let text = unwrappedPresenter.nameOfElement(at: enumSection, at: indexPath.row)
            cell.textLabel?.text = text
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let unwrappedPresenter = presenter,
            let enumSection = MainListSection(rawValue: section) else { return "" }
        return unwrappedPresenter.title(at: enumSection)
    }
}

extension MainViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        //Make sure we don't query empty texts from the serverndro
        if text != "" {
            presenter?.performSearch(with: text)
        }
        
    }
}

extension MainViewController: MainViewProtocol {
    func updateList() {
        tableView.reloadData()
    }
}

