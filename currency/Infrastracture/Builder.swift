import UIKit

protocol BuilderProtocol {
    
    init()
    static func resolveIntroductionViewController() -> IntroductionViewController
    static func resolveBanksViewController()->BanksViewController
    static func resolveBlackMarketViewController() -> BlackMarketViewController
    static func resolveNationalBankViewController() -> NationalBankViewController
    static func resolveBankMapViewController() -> BankMapViewController
    static func resolveBankMapPositionViewController(bankId: Int) -> BankMapPositionViewController
    static func resolveBottobMapDetailView(banksPositionAnnotation: BankMapAnnotation) -> BottomMapDetailView
    static func resolveTabBar() -> MainTabBarController
    static func resolveCalculatorViewController(buy : Double, sell : Double, title : String) -> CalculatorViewController
}

class Builder: BuilderProtocol {
    
    required init() {
        
    }
    
    static func resolveIntroductionViewController() -> IntroductionViewController {
        let vc = IntroductionViewController.instantiateMyViewController(name: .introduction)
        vc.presenter = IntroductionPresenter(view: vc)
        return vc
    }
    
    static func resolveTabBar() -> MainTabBarController {
        let vc = MainTabBarController()
        vc.presenter = MainTabBarPresenter(view: vc, bankAPI: BankAPI(queryHelper: QueryHelper.shared))
        return vc
    }
    
    static func resolveBanksViewController()->BanksViewController {
        let vc = BanksViewController.instantiateMyViewController(name: .banks)
        vc.presenter = BanksPresenter(view: vc, banksAPI: BankAPI(queryHelper: QueryHelper.shared), router: Router.sharedInstance)
        return vc
    }
    
    static func resolveCalculatorViewController(buy : Double, sell : Double, title : String) -> CalculatorViewController {
        let vc = CalculatorViewController.instantiateMyViewController(name: .calculator)
        vc.presenter = CalculatorPresenter(view: vc, buy: buy, sell: sell, title: title)
        return vc
    }
    
    static func resolveBlackMarketViewController() -> BlackMarketViewController {
        let vc = BlackMarketViewController.instantiateMyViewController(name: .blackMarket)
        vc.presenter = BlackMarketPresenter(view: vc, blackMarketAPI: BlackMarketAPI(), router: Router.sharedInstance)
        return vc
    }
    
    static func resolveNationalBankViewController() -> NationalBankViewController {
        let vc = NationalBankViewController.instantiateMyViewController(name: .nationalBank)
        vc.presenter = NationalBankPresenter(view: vc, nationalBankAPI: NationalBankAPI())
        return vc
    }
    
    static func resolveBankMapViewController() -> BankMapViewController {
        let vc = BankMapViewController.instantiateMyViewController(name: .bankMap)
        vc.presenter = BankMapPresenter(view: vc, bankNearMeAPI: BankMapAPI(queryHelper: QueryHelper.shared))
        return vc
    }
    
    static func resolveBankMapPositionViewController(bankId: Int) -> BankMapPositionViewController {
        let vc = BankMapPositionViewController.instantiateMyViewController(name: .bankPositionMap)
        vc.presenter = BankMapPositionPresenter(view: vc, positionAPI: BankMapPositionAPI(queryHelper: QueryHelper.shared), bankId: bankId)
        return vc
    }
    
    static func resolveBottobMapDetailView(banksPositionAnnotation: BankMapAnnotation) -> BottomMapDetailView {
        let view = BottomMapDetailView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 400))
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-380, width: UIScreen.main.bounds.width, height: 400)
        })
        view.presenter = BottomMapDetailPresenter(view: view, banksPositionAnnotation: banksPositionAnnotation)
        return view
        
    }
    
}

enum ViewControllerKeys : String {
    case blackMarket = "BlackMarket"
    case banks = "Banks"
    case nationalBank = "NationalBank"
    case bankMap = "BankMap"
    case bankPositionMap = "BankMapPosition"
    case calculator = "Calculator"
    case introduction = "Introduction"
}

