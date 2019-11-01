//
//  MainPresenter.swift
//  LastFM
//
//  Created by Alejandro Rodriguez on 10/31/19.
//  Copyright © 2019 Alejandro Rodriguez. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    required init(with delegate: MainViewProtocol) {
        view = delegate
    }
    
    func performSearch(with text: String) {
        print(text)
    }
}
