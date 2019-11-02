//
//  MainListHeaderViewTableViewCell.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/2/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit

class MainListHeaderViewTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTextLabel: UILabel!
    
    func setTitle(with text: String) {
        headerTextLabel.text = text
    }
}
