//
//  BottomDetailPresenter.swift
//  currency
//
//  Created by Tanya Koldunova on 16.03.2022.
//

import UIKit

protocol BottomMapDetailViewProtocol: AnyObject {
    func configure(_ model: BankMapAnnotation)
}

protocol BottomMapDetailPresenterProtocol: AnyObject {
    init(view: BottomMapDetailViewProtocol, banksPositionAnnotation: BankMapAnnotation)
    func updateAnnotation(banksPositionAnnotation: BankMapAnnotation)
    var banksPositionAnnotation : BankMapAnnotation { get set }
    func callByCurrentNumber(_ number: String?)
    
}

class BottomMapDetailPresenter: BottomMapDetailPresenterProtocol {
    weak var view: BottomMapDetailViewProtocol?
    var banksPositionAnnotation: BankMapAnnotation
    
    required init(view: BottomMapDetailViewProtocol, banksPositionAnnotation: BankMapAnnotation) {
        self.view = view
        self.banksPositionAnnotation = banksPositionAnnotation
        view.configure(banksPositionAnnotation)
        
    }
    
    func updateAnnotation(banksPositionAnnotation: BankMapAnnotation) {
        self.banksPositionAnnotation = banksPositionAnnotation
        guard let view = view else {return}
        view.configure(banksPositionAnnotation)
    }
    
    func callByCurrentNumber(_ number: String?) {
        let phoneUrl = URL(string: "tel:\(number ?? "")")!
        if(UIApplication.shared.canOpenURL(phoneUrl)) {
            UIApplication.shared.open(phoneUrl)
        }
    }
    
    
    
    
}
