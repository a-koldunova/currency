//
//  BankMapPositionViewController.swift
//  currency
//
//  Created by Tanya Koldunova on 16.03.2022.
//

import UIKit
import MapKit

class BankMapPositionViewController: BaseMapViewController<BankMapPositionPresenter> {
    @IBOutlet weak var bankPositionMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseMapDelegate = self
//        navigationItem.title = presenter.title
        // Do any additional setup after loading the view.
    }

}

extension BankMapPositionViewController: BaseMapDelegate {
    func getMap() -> MKMapView {
        return bankPositionMapView
    }
    
    func findBanks(lat: Double, lon: Double) {
        presenter.getBankPositionModel(lat: lat, lon: lon)
    }
    
    func centerMapOnLocation(lat: Double, lon: Double, radius: Double) {
        presenter.centerMapOnLocation(mapView: bankPositionMapView, lat: lat, lon: lon, radius: 100.0)
    }
    
    func shallUpdate(location: CLLocation?, userLocation: CLLocation?) -> Bool {
        presenter.shallUpdate(location: location, userLocation: userLocation)
    }
    
    
}

extension BankMapPositionViewController: BankMapPositionViewProtocol {
    func setAnnotation(annotations: [BankMapAnnotation]) {
        DispatchQueue.main.async {
            self.bankPositionMapView.addAnnotations(annotations)
        }
    }
    
    
}
