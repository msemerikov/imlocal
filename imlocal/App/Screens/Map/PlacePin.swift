//
//  PlacePin.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 27.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class PlacePin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(place: PlacesResult) {
        
        self.title = place.shopShortName
        if let street = place.shopAddress?.street, let houseNumber = place.shopAddress?.houseNumber {
            self.locationName = "\(street) \(houseNumber)"
        } else {
            self.locationName = ""
        }
        
        if let latitude = place.shopAddress?.latitude,
            let longitude = place.shopAddress?.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String? {
        return locationName
    }
    
    var imageName: String? {
        return "PinMarker"
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
