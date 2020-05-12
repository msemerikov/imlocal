//
//  PlacePinView.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 27.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation
import MapKit

class PlacePinMarkerView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let placePin = newValue as? PlacePin else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let imageName = placePin.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
    
}

class PlacePinView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let placePin = newValue as? PlacePin else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Places"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton
            
            if let imageName = placePin.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
            
//            let detailView = UIView()
//            let detailLabel = UILabel()
//            detailLabel.numberOfLines = 0
//            detailLabel.font = detailLabel.font.withSize(12)
//            detailLabel.text = placePin.subtitle
//            detailView.addSubview(detailLabel)
//            detailLabel.translatesAutoresizingMaskIntoConstraints = false
//            detailLabel.topAnchor.constraint(equalTo: detailView.topAnchor).isActive = true
//            detailLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
//            detailLabel.widthAnchor.constraint(equalTo: detailView.widthAnchor).isActive = true
//            detailLabel.heightAnchor.constraint(equalTo: detailView.heightAnchor).isActive = true
//            detailCalloutAccessoryView = detailView
        }
    }
    
}
