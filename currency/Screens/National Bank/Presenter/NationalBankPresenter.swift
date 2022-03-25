//
//  NationalBankPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation


protocol NationalBankViewProtocol: SwiftMessagesManager {
    func reloadData()
    func activityIndicatorStartAnimating()
    func activityIndicatorStopAnimating()
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
        nationalBankAPI.getNationalBankModel { model, error in
            if let error = error, model == nil {
                self.view?.showMessages(theme: .error, withMessage: MessagesText.error, isForeverDuration: false, actionText: nil, action: nil)
                self.nationalBankModel = FileUtils.getStructFromFile(directoryName: directoryName, fileName: .nationalBank)
            } else {
                self.nationalBankModel = model
            }
            self.view?.activityIndicatorStopAnimating()
            self.view?.reloadData()
        }
    }
    
    
}

