import UIKit

protocol BlackMarketProtocol : SwiftMessagesManager {
    func setAnimationStart(id : Int)
    func tableViewReloadData()
    func activityIndictorStartAnimating()
    func activityIndictorStopAnimating()
    func endRefreshing()
    func setChartView()
}

protocol BlackMarketPresenterProtocol : AnyObject {
    init(view : BlackMarketProtocol, blackMarketAPI : BlackMarketAPILMP, router : RouterProtocol)
    func goToCalculator( _ self : UIViewController, buy : Double, sell : Double, title : String)
    var blackMarketModel: BlackMarketModel? { get  set }
    var blackImage : [AppImage] { get set }
    func getBlackMarket()
    
}

class BlackMarketPresenter : BlackMarketPresenterProtocol {
    var blackImage: [AppImage] = [.dollarImage, .euroImage, .rubleImage]
    weak var view : BlackMarketProtocol?
    let blackMarketAPI : BlackMarketAPILMP
    var blackMarketModel : BlackMarketModel?
    let router :  RouterProtocol?
    var curArr : [currencyEn] = [.usd, .eur, .rub]
    
    required init(view: BlackMarketProtocol, blackMarketAPI : BlackMarketAPILMP, router : RouterProtocol) {
        self.view = view
        self.blackMarketAPI = blackMarketAPI
        self.router = router
        self.getBlackMarket()
    }
    
    func getBlackMarket() {
        self.view?.activityIndictorStartAnimating()
        blackMarketAPI.getBlackMarketData { model, error in
            self.view?.activityIndictorStopAnimating()
            self.view?.endRefreshing()
            if error != nil || model == nil {
                print(error!.localizedDescription)
                self.blackMarketModel = FileUtils.getStructFromFile(directoryName: directoryName, fileName: .blackMarcket)
                DispatchQueue.main.async {
                    self.view?.showMessages(theme: .error, withMessage: MessagesText.error, isForeverDuration: false, actionText: nil, action: nil)
                }
            } else {
            self.blackMarketModel = model
            self.view?.setChartView()
            }
            if let id = self.blackMarketModel?.forecast { self.view?.setAnimationStart(id: id) }
            self.view?.tableViewReloadData()
        }
    }
    
    func goToCalculator( _ self : UIViewController, buy : Double, sell : Double, title : String) {
        router?.goToCalculatorViewController(self, buy: buy, sell: sell, title: title)
    }
    
}

enum currencyEn {
    case usd
    case eur
    case rub
}

