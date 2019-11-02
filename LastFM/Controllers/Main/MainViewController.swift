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
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footer = tableView.dequeueReusableCell(withIdentifier: footerReusableName) as? MainListFooterViewTableViewCell,
            let enumSection = MainListSection(rawValue: section) {
            footer.section = enumSection
            footer.view = self
            return footer.contentView
        } else {
            return nil
        }
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
    func updateList() {
        tableView.reloadData()
    }
    
    func didPressEntireList(with section: MainListSection) {
        print(section)
    }
}

