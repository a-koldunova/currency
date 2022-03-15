//
//  BankMapPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation
import MapKit

protocol BankMapViewProtocol: AnyObject {
   func getLocation() -> CLLocation?
   func setAnnotation(annotations: [BankMapAnnotation])
}

protocol BankMapPresenterProtocol: AnyObject {
    init(view: BankMapViewProtocol, bankNearMeAPI: BankMapApiProtocol)
    var banksPositionAnnotation : [BankMapAnnotation]? { get set }
    func centerMapOnLocation(mapView: MKMapView)
    func shallUpdate(location:CLLocation?, userLocation: CLLocation?)->Bool
}

class BankMapPresenter: BankMapPresenterProtocol {
    weak var view: BankMapViewProtocol?
    var banksPositionAnnotation : [BankMapAnnotation]?
    private var bankNearMeAPI: BankMapApiProtocol
    
    required init(view: BankMapViewProtocol, bankNearMeAPI: BankMapApiProtocol) {
        self.view = view
        self.bankNearMeAPI = bankNearMeAPI
        getNearMePosition()
    }
    
    func getNearMePosition() {
        let location = view?.getLocation()
        if location != nil {
            bankNearMeAPI.getModelNearMe(lat: location!.coordinate.latitude, lon: location!.coordinate.longitude) { model in
                self.banksPositionAnnotation = model
                self.view?.setAnnotation(annotations: model)
            }
        }
    }
    
    func centerMapOnLocation(mapView: MKMapView) {
        let location = view?.getLocation()
        let coordinateRegion = MKCoordinateRegion.init(center: location!.coordinate,
                                                       latitudinalMeters: 1000.0 * 5.0, longitudinalMeters: 1000.0 * 5.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func shallUpdate(location:CLLocation?, userLocation: CLLocation?)->Bool{
        if location == nil{
            return false
        }
        if userLocation == nil{
            return true
        }
        return abs(location!.coordinate.latitude-userLocation!.coordinate.latitude)>0.001 || abs(location!.coordinate.longitude-userLocation!.coordinate.longitude)>0.001
    }
    
}
