//
//  MainListFooterViewTableViewCell.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/2/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit

class MainListFooterViewTableViewCell: UITableViewCell {

    var section: MainListSection?
    weak var view: MainViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func hola(_ sender: Any) {
        print("hola")
    }
    
//    @IBAction func didPressEntireListButton(_ sender: Any) {
//        guard let unwrappedSection = section else { return }
//        view?.didPressEntireList(with: unwrappedSection)
//    }
}
