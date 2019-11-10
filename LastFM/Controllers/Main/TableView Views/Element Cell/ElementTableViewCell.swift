//
//  ElementTableViewCell.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/4/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import AlamofireImage

class ElementTableViewCell: UITableViewCell {

    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!
    
    
    
    func update(with text: String, imageStURL: String?) {
        elementLabel.text = text
        if imageStURL != nil {
            elementImageView.af_setImage(withURL: URL(string: imageStURL!)!)
        } else {
            elementImageView.image = UIImage(named: "defaultImage")
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        elementImageView.image = nil
        elementImageView.af_cancelImageRequest()
    }
}
