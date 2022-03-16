//
//  BankPositionAPI.swift
//  currency
//
//  Created by Tanya Koldunova on 17.03.2022.
//

import Foundation

protocol BankMapPositionApiProtocol {
    func getPositionModel(lat: Double, lon: Double, bankId: Int, completion: @escaping ([BankMapAnnotation])->Void)
}

class BankMapPositionAPI: BankMapPositionApiProtocol {
    
    func getPositionModel(lat: Double, lon: Double, bankId: Int, completion: @escaping ([BankMapAnnotation]) -> Void) {
        let res = QueryHelper.shared.getBankPosition(lat: lat, lon: lon, bankId: bankId)
        completion(res)
    }

}
