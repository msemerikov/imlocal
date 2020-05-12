//
//  MapViewController.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 14.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import MapKit
import UIKit

protocol MapViewDelegate: AnyObject {
    func setLocality(_ location: String, coordinate: CLLocationCoordinate2D)
}

class MapViewController: UIViewController {
    
    // MARK: - Constants and variables
    var userCoordinate: CLLocationCoordinate2D?
    var isSetupLocation = false
    weak var delegate: MapViewDelegate?
    private let requestFactory = RequestFactory()
    var radius = 1000
    private var locationManager = LocationManager.instance
    private var geocodeRequestFuture: Timer?
    private var geocodeRequest: CLGeocoder? = CLGeocoder()
    private let mapView = MKMapView()
    private let objectAnnotation = MKPointAnnotation()
    private var circle = MKCircle()
    private var placePins: [PlacePin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .imlocalBackgroundColor
        setupMapView()
        mapView.delegate = self
        locationManager.startUpdatingLocation()
        
        if isSetupLocation {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
            mapView.isUserInteractionEnabled = true
            mapView.addGestureRecognizer(tapGestureRecognizer)
        } else {
            getPlaces()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.navigationController?.topViewController != self {
            print("back button tapped")
        }
    }
    
    // MARK: - Private methods
    /// Получение списка мест с сервера
    private func getPlaces() {
        let places = requestFactory.makePlacesRequestFactory()
//        let userPoint = "55.7776,37.4656"
        let coordinate = userCoordinate ?? (locationManager.locationManager.location?.coordinate ?? locationManager.defaultCoordinate)
        let userPoint = "\(coordinate.latitude),\(coordinate.longitude)"
        print(userPoint)
        let range = radius

        places.placesGet(userPoint: userPoint, range: range, page: 1, perPage: 10) { response in
            switch response.result {
            case .success(let places):
                places.forEach {place in
                    self.placePins.append(PlacePin(place: place)!)
                }
                self.mapView.addAnnotations(self.placePins)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Setup views
    /// Установка карты на экран
    private func setupMapView() {
        let coordinate = userCoordinate ?? (locationManager.locationManager.location?.coordinate ?? locationManager.defaultCoordinate)
        let camera = MKMapCamera(lookingAtCenter: coordinate,
                                 fromEyeCoordinate: coordinate,
                                 eyeAltitude: CLLocationDistance(radius * 6))
        mapView.setCamera(camera, animated: true)

        objectAnnotation.coordinate = coordinate
        mapView.addAnnotation(objectAnnotation)
        mapView.register(PlacePinView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        circle = MKCircle(center: coordinate, radius: CLLocationDistance(radius))
        mapView.addOverlay(circle)
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func geocodeRequestCancel() {
        geocodeRequestFuture?.invalidate()
        geocodeRequest?.cancelGeocode()
    }
    
    @objc private func mapTapped(_ recognizer: UITapGestureRecognizer) {
        mapView.removeOverlay(circle)
        let point: CGPoint = recognizer.location(in: mapView)
        let tapPoint: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: mapView)
        objectAnnotation.coordinate = tapPoint
        circle = MKCircle(center: tapPoint, radius: CLLocationDistance(radius))
        mapView.addOverlay(circle)

        let getLat: CLLocationDegrees = tapPoint.latitude
        let getLon: CLLocationDegrees = tapPoint.longitude
        let locationTouch: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
        coordinateToAdress(locationTouch)
    }
    
    func coordinateToAdress(_ location: CLLocation) {
        geocodeRequest?.reverseGeocodeLocation(location) { (placemarks, error) in
            var placemark: CLPlacemark!
            
            if let placemarks = placemarks {
                placemark = placemarks[0]
            }
            
            if let subLocality = placemark.subLocality {
                self.delegate?.setLocality(subLocality, coordinate: location.coordinate)
            } else if let locality = placemark.locality {
                self.delegate?.setLocality(locality, coordinate: location.coordinate)
            } else if let city = placemark.subAdministrativeArea {
                self.delegate?.setLocality(city, coordinate: location.coordinate)
            } else if let country = placemark.country {
                self.delegate?.setLocality(country, coordinate: location.coordinate)
            }
            
        }
    }

}

// MARK: - Map Delegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        geocodeRequestCancel()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.image = UIImage(named: "Pin")
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! PlacePin
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
       
        switch mode {
        case .follow:
            locationManager.locationManagerRequestLocation()
        default:
            break
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let circelOverLay = overlay as? MKCircle else { return MKOverlayRenderer() }

        let circleRenderer = MKCircleRenderer(circle: circelOverLay)
        circleRenderer.strokeColor = UIColor(red: 0.996, green: 0.541, blue: 0.502, alpha: 1)
        circleRenderer.fillColor = UIColor(red: 1, green: 0.842, blue: 0.842, alpha: 0.2)
        circleRenderer.lineWidth = 1.5
        return circleRenderer
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.removeOverlay(circle)
        let camera = MKMapCamera(lookingAtCenter: userLocation.coordinate,
                                 fromEyeCoordinate: userLocation.coordinate,
                                 eyeAltitude: CLLocationDistance(radius * 6))
        mapView.setCamera(camera, animated: true)
        circle = MKCircle(center: userLocation.coordinate, radius: CLLocationDistance(radius))
        mapView.addOverlay(circle)
    }
    
}
