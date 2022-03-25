//
//  NationalBankPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation


protocol NationalBankViewProtocol: AnyObject {
    func reloadData()
}

protocol NationalBankPresneterProtocol: AnyObject {
    init(view: NationalBankViewProtocol, nationalBankAPI: NationalBankAPIProtocol)
    var nationalBankModel: [NationalBankModel]? { get set }
    func getNationalBankApi()
}

class NationalBankPresenter: NationalBankPresneterProtocol {
    weak var view: NationalBankViewProtocol?
    private var nationalBankAPI: NationalBankAPIProtocol
    var nationalBankModel: [NationalBankModel]?
    
    required init(view: NationalBankViewProtocol, nationalBankAPI: NationalBankAPIProtocol) {
        self.view = view
        self.nationalBankAPI = nationalBankAPI
    }
    
    func getNationalBankApi() {
        nationalBankModel = FileUtils.getStructFromFile(directoryName: directoryName, fileName: .nationalBank)
        if nationalBankModel == nil || abs(DateHelper.differenceBtwNow(and: nationalBankModel?.last?.exchangedate ?? updateNeededData)) >  oneday {
        nationalBankAPI.getNationalBankModel { model, error in
            if let error = error {
                print(error.localizedDescription)
            }
            self.nationalBankModel = model
            self.view?.reloadData()
        }
        } else {
            //print(DateHelper.stringToDate(dateStr: nationalBankModel!.last!.exchangedate))
            view?.reloadData()
        }
    }
    
    
}

