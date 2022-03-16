//
//  BankMapViewController.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import UIKit
import MapKit
import CoreLocation

class BankMapViewController: BaseMapViewController<BankMapPresenterProtocol>  {
    @IBOutlet weak var bankMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseMapDelegate = self
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

}

extension BankMapViewController: BaseMapDelegate {
    func getMap() -> MKMapView {
        return bankMapView
    }
    
    func findBanks(lat:Double , lon: Double) {
        presenter.getNearMePosition(lat: lat, lon: lon)
    }
    
    func centerMapOnLocation(lat: Double, lon: Double, radius: Double) {
        presenter.centerMapOnLocation(mapView: bankMapView, lat: lat, lon: lon, radius: 1000.0)
    }
    
    func shallUpdate(location: CLLocation?, userLocation: CLLocation?) -> Bool {
        presenter.shallUpdate(location: location, userLocation: userLocation)
    }
    
    
}

extension BankMapViewController: BankMapViewProtocol {
    
    func setAnnotation(annotations: [BankMapAnnotation]) {
        DispatchQueue.main.async {
            self.bankMapView.addAnnotations(annotations)
        }
    }
    
    
}
