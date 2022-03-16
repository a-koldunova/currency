//
//  BankMapPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation
import MapKit

protocol BankMapViewProtocol: AnyObject {
   func setAnnotation(annotations: [BankMapAnnotation])
}

protocol BankMapPresenterProtocol: AnyObject {
    init(view: BankMapViewProtocol, bankNearMeAPI: BankMapApiProtocol)
    var banksPositionAnnotation : [BankMapAnnotation]? { get set }
    func getNearMePosition(lat: Double, lon: Double)
    func centerMapOnLocation(mapView: MKMapView, lat:Double , lon: Double, radius:Double)
    func shallUpdate(location:CLLocation?, userLocation: CLLocation?)->Bool
}

class BankMapPresenter: BankMapPresenterProtocol {
    weak var view: BankMapViewProtocol?
    var banksPositionAnnotation : [BankMapAnnotation]?
    private var bankNearMeAPI: BankMapApiProtocol
    
    required init(view: BankMapViewProtocol, bankNearMeAPI: BankMapApiProtocol) {
        self.view = view
        self.bankNearMeAPI = bankNearMeAPI
    }
    
    func getNearMePosition(lat: Double, lon: Double) {
            bankNearMeAPI.getModelNearMe(lat: lat, lon: lon) { model in
                self.banksPositionAnnotation = model
                self.view?.setAnnotation(annotations: model)
            
        }
    }
    
    func centerMapOnLocation(mapView: MKMapView, lat:Double , lon: Double, radius:Double) {
        let location = CLLocation(latitude: lat, longitude: lon)
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                       latitudinalMeters: radius * 5.0, longitudinalMeters: radius * 5.0)
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
