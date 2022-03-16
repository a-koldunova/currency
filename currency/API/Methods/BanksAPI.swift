//
//  BanksAPI.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//

import Foundation


protocol BankAPIlmp: APIManager {
    func getBankAPI(completion: @escaping(BanksModel?, Error?)->Void)
}

class BankAPI: APIManager, BankAPIlmp {
    
    func getBankAPI(completion: @escaping(BanksModel?, Error?)->Void) {
        jsonGetRequest(url: "https://infoship.xyz/curr/uahb.php?cli=9", returningType: BanksModel.self) { model, error in
            completion(model, error)
            if model != nil {
                QueryHelper.shared.insertRates(model!)
            }
        }
    }
    
    
}
