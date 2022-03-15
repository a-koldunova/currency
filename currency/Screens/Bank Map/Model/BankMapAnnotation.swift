//
//  BankMapModel.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation
import MapKit

public class BankMapAnnotation: NSObject, MKAnnotation {
    public let bankName: String
    public let address: String
    public let phone: Int
    public let coordinate: CLLocationCoordinate2D
    public let curr: String
    public let buy: Double
    public let sell: Double
    
    init(bankName: String, address: String, phone: Int, lat: Double, lon: Double, curr: String, buy: Double, sell: Double) {
        self.bankName = bankName
        self.address = address
        self.phone = phone
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.curr = curr
        self.buy = buy
        self.sell = sell
    }
}
