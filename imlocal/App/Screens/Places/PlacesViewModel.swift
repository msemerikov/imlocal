//
//  PlacesViewModel.swift
//  imlocal
//
//  Created by Denis on 15.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

class PlacesViewModel {
    
    private let placesModel = PlacesModel()
    
    var items: [PlacesResult] = []
    var filteredItems: [PlacesResult] = []
    
    var itemsChanged: (() -> ())?
    
    func handleViewReady(userPoint: String, range: Int, page: Int, perPage: Int) {
        placesModel.getData(userPoint: userPoint, range: range, page: page, perPage: perPage) { result in
            guard let result = result else { return }
            self.items = result
            self.filteredItems = result
            self.itemsChanged?()
        }
    }
    
    func filter(searchString: String) {
        
        guard !searchString.isEmpty else {
            filteredItems = items
            return
        }
        
        filteredItems = items.filter({
            ($0.shopShortName?.lowercased().contains(searchString.lowercased()))!
        })
        
    }
    
    func numberOfRowsInSection() -> Int {
        return filteredItems.count
    }
}
