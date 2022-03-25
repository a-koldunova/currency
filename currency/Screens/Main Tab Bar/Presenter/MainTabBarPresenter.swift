//
//  MainTabBarPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 17.03.2022.
//


import UIKit

protocol MainTabBarViewProtocol: SwiftMessagesManager {
    func getTabBar() -> UITabBar
}

protocol MainTabBarPresenterProtocol: AnyObject {
    init(view: MainTabBarViewProtocol, bankAPI: BankAPIProtocol)
    func getBankData()
}

class MainTabBarPresenter: MainTabBarPresenterProtocol {
    weak var view: MainTabBarViewProtocol?
    private var bankAPI: BankAPIProtocol
    var nationalBankModel: [NationalBankModel]?
    
    required init(view: MainTabBarViewProtocol, bankAPI: BankAPIProtocol) {
        self.view = view
        self.bankAPI = bankAPI
        getBankData()
    }
    
    func getBankData() {
        bankAPI.getBankAPI { res, error in
            if let error = error {
                print(error.localizedDescription)
                self.view?.showMessages(theme: .error, withMessage: MessagesText.error.rawValue, isForeverDuration: false, actionText: nil, action: nil)
            } 
        }
    }
    
    
    
}
