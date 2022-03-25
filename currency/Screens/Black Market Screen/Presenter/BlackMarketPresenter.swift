import UIKit

protocol BlackMarketProtocol : SwiftMessagesManager {
    func setAnimationStart(id : Int)
    func tableViewReloadData()
}

protocol BlackMarketPresenterProtocol : AnyObject {
    init(view : BlackMarketProtocol, blackMarketAPI : BlackMarketAPILMP, router : RouterProtocol)
    func goToCalculator( _ self : UIViewController, buy : Double, sell : Double, title : String)
    var blackMarketModel: BlackMarketModel? { get  set }
    var blackImage : [AppImage] { get set }
}

class BlackMarketPresenter : BlackMarketPresenterProtocol {
    var blackImage: [AppImage] = [.dollarImage, .euroImage, .rubleImage]
    let view : BlackMarketProtocol
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
        blackMarketModel = FileUtils.getStructFromFile(directoryName: directoryName, fileName: .blackMarcket)
        if blackMarketModel == nil || DateHelper.diffBtwNow(and: Double(blackMarketModel?.time ?? 0)) > oneday {
            blackMarketAPI.getBlackMarketData { model, error in
                if let error = error { print(error.localizedDescription); self.view.showMessages(theme: .error, withMessage: MessagesText.error.rawValue, isForeverDuration: false, actionText: nil, action: nil); return }
                self.blackMarketModel = model
                self.view.tableViewReloadData()
                if let id = self.blackMarketModel?.forecast { self.view.setAnimationStart(id: id) }
            }
        } else {
            self.view.tableViewReloadData()
            if let id = self.blackMarketModel?.forecast { self.view.setAnimationStart(id: id) }
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

