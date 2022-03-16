//
//  BankMapApi.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation


protocol BankMapApiProtocol {
    func getModelNearMe(lat: Double, lon: Double, completion: @escaping ([BankMapAnnotation])->Void)
}

class BankMapAPI: BankMapApiProtocol {
    
    func getModelNearMe(lat: Double, lon: Double, completion: @escaping ([BankMapAnnotation]) -> Void) {
        let res = QueryHelper.shared.getBanksNearMe(lat: lat, lon: lon)
        completion(res)
    }

}
