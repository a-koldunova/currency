//
//  Presenter.swift
//  currency
//
//  Created by Anastasia Koldunova on 14.03.2022.
//

import Foundation


protocol CalculatorProtocol : AnyObject {
    
}

protocol CalculatorPresenterProtocol : AnyObject {
    init(view:CalculatorProtocol, buy : Double, sell : Double)
}

class CalculatorPresenter : CalculatorPresenterProtocol {
    let view : CalculatorProtocol
    let buy : Double
    let sell : Double
    
    required init(view: CalculatorProtocol, buy : Double, sell : Double) {
        self.view = view
        self.buy = buy
        self.sell = sell
    }
    
    
}
