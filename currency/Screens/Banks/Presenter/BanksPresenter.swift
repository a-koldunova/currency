import UIKit

protocol BanksViewProtocol: SwiftMessagesManager {
    func reloadData()
}

protocol BanksPresenterProtocol: AnyObject {
    init(view: BanksViewProtocol, banksAPI: BankAPIlmp, queryHelper : QueryHelperProtocol, router : RouterProtocol)
    func getCurrency(_ index: Int) -> Currency
    func getArray(_ index: Int) -> [BuySellModel]
    var banksModel: BanksModel? { get set }
    func getBanks()
    func getBankName(id: Int) -> String?
    func getBankLink(id : Int) -> String?
    func goToTheSite(for link : String)
    func goToCalculatorVC(_ self : UIViewController)
}

class BanksPresenter: BanksPresenterProtocol {
    
    weak var view: BanksViewProtocol?
    private var banksAPI: BankAPIlmp
    var banksModel: BanksModel?
    let queryHelper : QueryHelperProtocol
    let router : RouterProtocol
    
    required init(view: BanksViewProtocol, banksAPI: BankAPIlmp, queryHelper : QueryHelperProtocol, router : RouterProtocol) {
        self.view = view
        self.banksAPI = banksAPI
        self.queryHelper = queryHelper
        self.router = router
        //        getBanks()
    }
    
    func goToTheSite(for link : String) {
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            view?.showMessages(theme: .error, withMessage: MessagesText.error.rawValue, isForeverDuration: false, actionText: nil, action: nil)
        }
    }
    
    func goToCalculatorVC(_ self : UIViewController) {
        router.goToCalculatorViewController(parentVC: self)
    }
    
    func getBanks() {
        banksAPI.getBankAPI { model, error in
            if let error = error {
                print(error.localizedDescription)
            }
            self.banksModel = model
            self.view?.reloadData()
        }
    }
    
    func getBankName(id: Int) -> String? {
        return queryHelper.getNameOfBank(by: id)
    }
    
    func getBankLink(id : Int) -> String? {
        return queryHelper.getLink(by: id)
    }
    
    func getArray(_ index: Int) -> [BuySellModel] {
        switch index {
        case 0:
            return banksModel?.usd ?? [BuySellModel]()
        case 1:
            return banksModel?.eur ?? [BuySellModel]()
        case 2:
            return banksModel?.rub ?? [BuySellModel]()
        default:
            break
        }
        return [BuySellModel]()
    }
    
    func getCurrency(_ index: Int) -> Currency {
        switch index {
        case 0:
            return .usd
        case 1:
            return .eur
        case 2:
            return .rub
        default:
            return .usd
        }
        
    }
    
}


enum Currency {
    case usd
    case eur
    case rub
}
