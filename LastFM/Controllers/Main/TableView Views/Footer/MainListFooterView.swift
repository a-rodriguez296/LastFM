//
//  Prueba.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 11/4/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class MainListFooterView: UIView {
    
    
    @IBOutlet weak var label: UILabel!
    
    weak var view: MainViewProtocol?
    var section: MainListSection?
    
    func setLabel(with section: MainListSection) {
        
        self.section = section
        
        switch section {
        case .album:
            label.text = "If you want to see more albums"
        case .artist:
            label.text = "If you want to see more artists"
        case .track:
            label.text = "If you want to see more tracks"
        }
    }
    
    @IBAction func didPressMore(_ sender: Any) {
        guard let unwrappedSection = section else { return }
        view?.didPressEntireList(with: unwrappedSection)
    }
    
}
