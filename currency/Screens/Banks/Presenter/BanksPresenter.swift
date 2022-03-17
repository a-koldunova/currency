import UIKit

protocol BanksViewProtocol: SwiftMessagesManager {
    func reloadData()
}

protocol BanksPresenterProtocol: AnyObject {
    init(view: BanksViewProtocol, banksAPI: BankAPIProtocol, router : RouterProtocol)
    func getArray(_ index: Int) -> [BankFullInfoModel]
    var banksModel: BankCurrencyModel? { get set }
    func getBanks()
    func goToTheSite(for link : String)
    func goToCalculatorVC(_ self : UIViewController)
}

class BanksPresenter: BanksPresenterProtocol {
    
    weak var view: BanksViewProtocol?
    private var banksAPI: BankAPIProtocol
    var banksModel: BankCurrencyModel?
    let router : RouterProtocol
    
    required init(view: BanksViewProtocol, banksAPI: BankAPIProtocol, router : RouterProtocol) {
        self.view = view
        self.banksAPI = banksAPI
        self.router = router
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
        banksAPI.getSaveData { model in
            self.banksModel = model
            self.view?.reloadData()
        }
    }
    
    func reloadData() {
        banksAPI.reloadData { model, error in
            if let error = error {
                print(error.localizedDescription)
            }
            self.banksModel = model
        }
    }
    
    func getArray(_ index: Int) -> [BankFullInfoModel] {
        switch index {
        case 0:
            return banksModel?.usd ?? [BankFullInfoModel]()
        case 1:
            return banksModel?.eur ?? [BankFullInfoModel]()
        case 2:
            return banksModel?.rub ?? [BankFullInfoModel]()
        default:
            break
        }
        return [BankFullInfoModel]()
    }
    
}


