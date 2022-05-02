//
//  BankMapModel.swift
//  currency
//
//  Created by Anastasia Koldunova on 14.03.2022.
//

import Foundation
import MapKit

 class BankMapAnnotation: NSObject, MKAnnotation {
     let title: String?
     let address: String
     let phone: Int
     let coordinate: CLLocationCoordinate2D
     let exchangeModel: [ExchangeBankModel]?
   
    
    init(bankName: String, address: String, phone: Int, lat: Double, lon: Double, exchangeModel: [ExchangeBankModel]?) {
        self.title = bankName
        self.address = address
        self.phone = phone
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.exchangeModel = exchangeModel
    }
}
