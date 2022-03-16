import UIKit

protocol BuilderProtocol {

    init()
    static func resolveBanksViewController()->BanksViewController
    static func resolveBlackMarketViewController() -> BlackMarketViewController
    static func resolveTabBar() -> MainTabBarController
    static func resolveCalculatorViewController() -> CalculatorViewController
}

class Builder: BuilderProtocol {
   
    required init() {
        
    }
    
    static func resolveTabBar() -> MainTabBarController {
        return MainTabBarController()
    }
    
    static func resolveBanksViewController()->BanksViewController {
        let vc = BanksViewController.instantiateMyViewController(name: .banks)
        vc.presenter = BanksPresenter(view: vc, banksAPI: BankAPI(), queryHelper: QueryHelper.shared, router: Router.sharedInstance)
        return vc
    }

    static func resolveCalculatorViewController() -> CalculatorViewController {
        let vc = CalculatorViewController.instantiateMyViewController(name: .calculator)
        vc.presenter = CalculatorPresenter(view: vc, buy: 30, sell: 30)
        return vc
    }
    
    static func resolveBlackMarketViewController() -> BlackMarketViewController {
        let vc = BlackMarketViewController.instantiateMyViewController(name: .blackMarket)
        vc.presenter = BlackMarketPresenter(view: vc, blackMarketAPI: BlackMarketAPI(), router: Router.sharedInstance)
        return vc
    }
    
}

enum ViewControllerKeys : String {
    case blackMarket = "BlackMarket"
    case banks = "Banks"
    case calculator = "Calculator"
}
    
