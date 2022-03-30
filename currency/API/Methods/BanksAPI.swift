//
//  BanksAPI.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//

import Foundation


protocol BankAPIProtocol: NSObject {
    init(queryHelper: QueryHelperProtocol)
    func getBankAPI(completion: @escaping(Bool?, Error?)->Void)
    func getSaveData(completion: @escaping (BankCurrencyModel?)->Void)
    func reloadData(completion: @escaping (BankCurrencyModel?, Error?)->Void)
}

class BankAPI: NSObject, BankAPIProtocol {
    
    
    let queryHelper: QueryHelperProtocol
    
    required init(queryHelper: QueryHelperProtocol) {
        self.queryHelper = queryHelper
    }
    
    func getBankAPI(completion: @escaping(Bool?, Error?)->Void) {
        serialQueue.async {
            apiSemaphore.wait()
    //        sleep(10)
            APIManager.jsonGetRequest(url: "https://infoship.xyz/curr/uahb.php?cli=9", returningType: BanksModel.self) { model, error in
                if model != nil {
                    let res = QueryHelper.shared.insertRates(model!)
                    UserDefaults.standard.set(Double(model!.ts), forKey: banks_key)
                    completion(res, error)
                    apiSemaphore.signal()
                }
                
            }
        }
    }
    
    func reloadData(completion: @escaping (BankCurrencyModel?, Error?)->Void) {
        getBankAPI { go, error in
            if let error = error {
                completion(nil, error)
            } else {
                if go == true {
                    self.getSaveData { model in
                        completion(model, nil)
                    }
                }
            }
        }
    }
    
    func getSaveData(completion: @escaping (BankCurrencyModel?)->Void) {
        let usdModel = getCurr(curr: .usd)
        let eurModel = getCurr(curr: .eur)
        let rubModel = getCurr(curr: .rub)
        completion(BankCurrencyModel(usd: usdModel, eur: eurModel, rub: rubModel))
    }
    
    func getCurr(curr: Currency) -> [BankFullInfoModel] {
        let currData = queryHelper.getBanksRatesData(curr: curr.rawValue)
        var currModel = [BankFullInfoModel]()
        for c in currData {
            let name = queryHelper.getNameOfBank(by: c.id)
            let link = queryHelper.getLink(by: c.id)
            if let name = name {
                currModel.append(BankFullInfoModel(id: c.id, exchange: ExchangeBankModel(name: name, b: String(format: (curr == .rub) ? "%.3f" : "%.2f", c.b), s: String(format: (curr == .rub) ? "%.3f" : "%.2f", c.s)), link: link ?? ""))
            }
        }
        return currModel
    }
    
}
