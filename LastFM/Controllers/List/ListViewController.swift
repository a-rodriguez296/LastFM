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
}

extension ListViewController: ListViewProtocol {
    func updateList() {
        tableView.reloadData()
    }
}
