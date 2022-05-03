//
//  BankMapPOsitionPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 16.03.2022.
//

import Foundation
import MapKit

protocol BankMapPositionViewProtocol: AnyObject {
   func setAnnotation(annotations: [BankMapAnnotation])
    func activityIndicatorStartAnimating()
    func activityIndicatorStopAnimating()
}

protocol BankMapPositionPresenterProtocol: AnyObject {
    init(view: BankMapPositionViewProtocol, positionAPI: BankMapPositionApiProtocol, bankId: Int)
    var banksPositionAnnotation : [BankMapAnnotation]? { get set }
    func getBankPositionModel(lat: Double, lon: Double)
    func centerMapOnLocation(mapView: MKMapView, lat:Double , lon: Double, radius:Double)
    func shallUpdate(location:CLLocation?, userLocation: CLLocation?)->Bool
}

class BankMapPositionPresenter: BankMapPositionPresenterProtocol {
    weak var view: BankMapPositionViewProtocol?
    var banksPositionAnnotation : [BankMapAnnotation]?
    var bankId: Int
    private var positionAPI: BankMapPositionApiProtocol
    
    required init(view: BankMapPositionViewProtocol, positionAPI: BankMapPositionApiProtocol, bankId: Int) {
        self.view = view
        self.positionAPI = positionAPI
        self.bankId = bankId
    }
    
    func getBankPositionModel(lat: Double, lon: Double) {
        self.view?.activityIndicatorStartAnimating()
        positionAPI.getPositionModel(lat: lat, lon: lon, bankId: bankId) { model in
            self.view?.setAnnotation(annotations: model)
            self.view?.activityIndicatorStopAnimating()
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
