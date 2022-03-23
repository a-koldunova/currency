//
//  NationalBankAPI.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation

protocol NationalBankAPIProtocol: NSObject  {
    func getNationalBankModel(completion: @escaping ([NationalBankModel]?, Error?)->Void)
}

class NationalBankAPI: NSObject, NationalBankAPIProtocol {
    
    func getNationalBankModel(completion: @escaping ([NationalBankModel]?, Error?) -> Void) {
        APIManager.jsonGetRequest(url: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json", returningType: [NationalBankModel].self) { model, error in
            FileUtils.writeToFile(directoryName: directoryName, fileName: .nationalBank, model: model)
            completion(model, error)
        }
    }    
    
}
