//
//  Presenter.swift
//  currency
//
//  Created by Anastasia Koldunova on 14.03.2022.
//

import UIKit


protocol CalculatorProtocol : AnyObject {
    
}

protocol CalculatorPresenterProtocol : AnyObject {
    init(view:CalculatorProtocol, buy : Double, sell : Double, title : String)
    func convert(value : Double, to : Double, from : Double) -> String?
    var buy : Double {get}
    var sell : Double {get}
    var clearUserTF : Bool { get set }
    var clearBuyTF : Bool { get set }
    var clearSellTF : Bool { get set }
    var title : String { get }
}

class CalculatorPresenter : CalculatorPresenterProtocol {
    let view : CalculatorProtocol
    var buy : Double
    var sell : Double
    var clearUserTF : Bool = true
    var clearBuyTF : Bool = true
    var clearSellTF : Bool = true
    var title: String
    
    required init(view: CalculatorProtocol, buy : Double, sell : Double, title : String) {
        self.view = view
        self.buy = buy
        self.sell = sell
        self.title = title
    }
    
    func convert(value : Double, to : Double, from : Double) -> String? {
        let nf=NumberFormatter()
        nf.decimalSeparator="."
        nf.groupingSeparator=" "
        nf.numberStyle = .decimal
        nf.maximumFractionDigits=2
        nf.minimumFractionDigits=2
        return nf.string(from: NSNumber(value: value * to/from))
    }
    
    
    
}

enum CalculatorAction {
    case userNumber
    case sell
    case buy
}
