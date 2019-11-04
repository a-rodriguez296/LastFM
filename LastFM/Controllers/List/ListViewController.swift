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
    
    // MARK: - Variables
    var presenter: ListPresenterProtocol?
    var keyword: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let repository = ListRepository()
        presenter = ListPresenter(with: self, repository: repository)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Watch out. This needs to be changed
        keyword = "Justin"
        presenter?.performSearch(with: keyword!)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        if let unwrappedPresenter = presenter {
            let text = unwrappedPresenter.nameOfElement(at: indexPath.row)
            cell.textLabel?.text = text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedPresenter = presenter
        else { return 0 }
        return unwrappedPresenter.numberOfRows()
    }
}

extension ListViewController: ListViewProtocol {
    func updateList() {
        tableView.reloadData()
    }
}
