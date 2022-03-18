//
//  BankMapApi.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation


protocol BankMapApiProtocol {
    init(queryHelper: QueryHelperProtocol)
    func getModelNearMe(lat: Double, lon: Double, completion: @escaping ([BankMapAnnotation])->Void)
}

class BankMapAPI: BankMapApiProtocol {
    var queryHelper: QueryHelperProtocol
    
    required init(queryHelper: QueryHelperProtocol) {
        self.queryHelper = queryHelper
    }
    
    func getModelNearMe(lat: Double, lon: Double, completion: @escaping ([BankMapAnnotation]) -> Void) {
        let res = queryHelper.getBanksNearMe(lat: lat, lon: lon)
        completion(res)
    }

}
