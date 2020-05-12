//
//  LocationManager.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 14.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import CoreLocation
import UIKit

protocol LocationManagerDelegate: AnyObject {
    func didBeginLocationUpdate()
}

final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    weak var delegate: LocationManagerDelegate?
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 55.7776, longitude: 37.4656)
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func locationManagerRequestLocation(withPermission permission: CLAuthorizationStatus? = nil) {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            guard let permission = permission else {
                return
            }
            switch permission {
            case .authorizedAlways:
                locationManager.requestAlwaysAuthorization()
            case .authorizedWhenInUse:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
            }
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                      options: [:]) { [weak self] _ in
                                        // TODO: Check if conflicts with locationManager(manager: didChangeAuthorization:)
                                        switch CLLocationManager.authorizationStatus() {
                                        case .authorizedAlways, .authorizedWhenInUse:
                                            self?.locationManager.requestLocation()
                                        default:
                                            break
                                        }
            }
        default:
            break
        }
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
//        stopUpdatingLocation()
        userLocation = location
//        print(userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
