import Foundation

protocol BanksViewProtocol: AnyObject {
    func reloadData()
}

protocol BanksPresenterProtocol: AnyObject {
    init(view: BanksViewProtocol, banksAPI: BankAPIlmp)
    func getCurrency(_ index: Int) -> Currency
    func getArray(_ index: Int) -> [BuySellModel]
    var banksModel: BanksModel? { get set }
    
}

class BanksPresenter: BanksPresenterProtocol {
    weak var view: BanksViewProtocol?
    private var banksAPI: BankAPIlmp
    var banksModel: BanksModel?
    
    required init(view: BanksViewProtocol, banksAPI: BankAPIlmp) {
        self.view = view
        self.banksAPI = banksAPI
        getBanks()
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
