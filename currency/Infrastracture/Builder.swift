import UIKit

protocol BuilderProtocol {

    init()
    static func resolveBanksViewController()->BanksViewController
    static func resolveBlackMarketViewController() -> BlackMarketViewController
    static func resolveNationalBankViewController() -> NationalBankViewController
    static func resolveBankMapViewController() -> BankMapViewController
}

class Builder: BuilderProtocol {
    
    required init() {
        
    }
    
    static func resolveBanksViewController()->BanksViewController {
        let vc = BanksViewController.instantiateMyViewController(name: .banks)
        vc.presenter = BanksPresenter(view: vc, banksAPI: BankAPI())
        return vc
    }


    static func resolveBlackMarketViewController() -> BlackMarketViewController {
        let vc = BlackMarketViewController.instantiateMyViewController(name: .blackMarket)
        vc.presenter = BlackMarketPresenter(view: vc)
        return vc
    }
    
    static func resolveNationalBankViewController() -> NationalBankViewController {
        let vc = NationalBankViewController.instantiateMyViewController(name: .nationalBank)
        vc.presenter = NationalBankPresenter(view: vc, nationalBankAPI: NationalBankAPI())
        return vc
    }
    
    static func resolveBankMapViewController() -> BankMapViewController {
        let vc = BankMapViewController.instantiateMyViewController(name: .bankMap)
        vc.presenter = BankMapPresenter(view: vc, bankNearMeAPI: BankMapAPI())
        return vc 
    }
    
}

enum ViewControllerKeys : String {
    case blackMarket = "BlackMarket"
    case banks = "Banks"
    case nationalBank = "NationalBank"
    case bankMap = "BankMap"
}
    
