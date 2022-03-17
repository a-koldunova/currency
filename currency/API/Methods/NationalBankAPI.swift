//
//  NationalBankAPI.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation

protocol NationalBankAPIProtocol: APIManager  {
    func getNationalBankModel(completion: @escaping ([NationalBankModel]?, Error?)->Void)
}

class NationalBankAPI: APIManager, NationalBankAPIProtocol {
    
    func getNationalBankModel(completion: @escaping ([NationalBankModel]?, Error?) -> Void) {
        jsonGetRequest(url: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json", returningType: [NationalBankModel].self) { model, error in
            completion(model, error)
        }
    }    
    
}
