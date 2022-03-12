import UIKit

protocol BuilderProtocol {
//    static func resolveBlackMarcket()
    static func resolveBanksViewController()->BanksViewController
}

class Builder: BuilderProtocol {

    let shared : Builder = Builder()
    
    static func resolveBanksViewController()->BanksViewController {
        let vc = BanksViewController.instantiateMyViewController(name: "Banks")
        vc.presenter = BanksPresenter(view: vc, banksAPI: BankAPI())
        return vc
    }
    
}
    
