//
//  BankMapViewController.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import UIKit
import MapKit
import CoreLocation

class BankMapViewController: MainViewController<BankMapPresenterProtocol> {
    @IBOutlet weak var bankMapView: MKMapView! {
        didSet {
            bankMapView.delegate = self
        }
    }
    
    var locationManager = CLLocationManager()
    var userLocation:CLLocation? {
        didSet{
            if userLocation != nil {
                DispatchQueue.main.async {
                    self.presenter.centerMapOnLocation(mapView: self.bankMapView)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
           // self.locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        bankMapView.isZoomEnabled = true
        bankMapView.isScrollEnabled = true
        navigationController?.navigationBar.isHidden = true
    }
    

}

extension BankMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? BankMapAnnotation else {return nil}
        let  pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.address)
        pinView.image = MainImage.bankIcon.image
        pinView.glyphImage = PictureUtils.getImageWithColor(UIColor.clear)
        pinView.markerTintColor = UIColor.clear
        pinView.annotation = annotation
        return pinView
    }
}

extension BankMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("got following error from loaction manager")
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if presenter.shallUpdate(location: locations.first, userLocation: userLocation)  {
            userLocation = locations.first
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse{
            userLocation = manager.location
            if userLocation != nil{
                presenter.centerMapOnLocation(mapView: self.bankMapView)
            }
        }
    }
}

extension BankMapViewController: BankMapViewProtocol {
    func getLocation() -> CLLocation? {
        return userLocation
    }
    
    func setAnnotation(annotations: [BankMapAnnotation]) {
        self.bankMapView.addAnnotations(annotations)
    }
    
    
}
