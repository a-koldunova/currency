//
//  BaseMapViewController.swift
//  currency
//
//  Created by Tanya Koldunova on 16.03.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol BaseMapDelegate {
    func getMap()->MKMapView
    func findBanks(lat:Double , lon: Double)
    func centerMapOnLocation(lat:Double , lon: Double, radius:Double)
    func shallUpdate(location:CLLocation?, userLocation: CLLocation?)->Bool
}

class BaseMapViewController<T>: MainViewController<T>, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    var baseMapDelegate: BaseMapDelegate?
    var bottomSheetView: BottomMapDetailView?
    var selectedAnnotation: String?
    
    var locationManager = CLLocationManager()
    var userLocation:CLLocation? {
        didSet{
            if userLocation != nil && baseMapDelegate != nil {
                DispatchQueue.main.async {
                    self.baseMapDelegate!.centerMapOnLocation(lat: self.userLocation!.coordinate.latitude , lon: self.userLocation!.coordinate.longitude, radius: 1000.0)
                }
                baseMapDelegate!.findBanks(lat: userLocation!.coordinate.latitude , lon: userLocation!.coordinate.longitude)
            }
        }
    }
    
    var fullViewY = UIScreen.main.bounds.height - 380
    var partialViewY = UIScreen.main.bounds.height - 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let baseMap = baseMapDelegate?.getMap() else {return}
        baseMap.delegate = self
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
           // self.locationManager.requestAlwaysAuthorization()
            switch locationManager.authorizationStatus {
            case .restricted, .denied:
                print("no eccess")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                //}
            @unknown default:
                break
            }
        }
        baseMap.isZoomEnabled = true
        baseMap.isScrollEnabled = true
    }
    
    @objc func didPan(_ sender: UIPanGestureRecognizer) {
        guard let bottomSheetView = bottomSheetView else {return}
        let translation = sender.translation(in: bottomSheetView)
        let velocity = sender.velocity(in: bottomSheetView)
        let minY = bottomSheetView.frame.minY
        if ( minY + translation.y >= fullViewY) && (minY + translation.y <= partialViewY  ) {
            bottomSheetView.frame = CGRect(x: 0, y: minY + translation.y, width: UIScreen.main.bounds.width, height: 600)
            sender.setTranslation(CGPoint.zero, in: self.bottomSheetView)
        }
        if sender.state == .ended {
            var duration =  velocity.y < 0 ? Double((minY - 300) / -velocity.y) : Double((80 - minY) / velocity.y )
            duration = duration > 1.3 ? 1 : duration
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    bottomSheetView.frame = CGRect(x: 0, y: self.partialViewY, width: self.view.frame.width, height: 600)
                } else {
                    bottomSheetView.frame = CGRect(x: 0, y: self.fullViewY, width: self.view.frame.width, height: 600)
                }
                
            }, completion: nil)
            
        }
    }
    
    //MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("got following error from loaction manager")
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let baseMapDelegate = baseMapDelegate  {
        if baseMapDelegate.shallUpdate(location: locations.first, userLocation: userLocation)  {
            userLocation = locations.first
        }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse{
            userLocation = manager.location
        }
    }
    
    //MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? BankMapAnnotation else {return nil}
        let  pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.address)
        pinView.image = AppImage.bankIcon.image
        pinView.glyphImage = PictureUtils.getImageWithColor(UIColor.clear)
        pinView.markerTintColor = UIColor.clear
        pinView.annotation = annotation
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let bankAnnotation = view.annotation as? BankMapAnnotation {
            if bottomSheetView == nil {
                bottomSheetView = Builder.resolveBottobMapDetailView(banksPositionAnnotation: bankAnnotation)
                self.view.addSubview(bottomSheetView!)
                let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
                bottomSheetView?.addGestureRecognizer(panGestureRecognizer)
            } else {
                bottomSheetView?.presenter.updateAnnotation(banksPositionAnnotation: bankAnnotation)
                bottomSheetView?.setFrame()
            }
            selectedAnnotation = bankAnnotation.address
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
    
    

}
