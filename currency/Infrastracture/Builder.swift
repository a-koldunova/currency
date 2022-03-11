import UIKit

protocol BuilderProtocol {
    init()
    func resolveBlackMarketViewController() -> BlackMarketViewController
}

class Builder: BuilderProtocol {

    static let shared : Builder = Builder()
    
    required init() {
        
    }
    
    func resolveBlackMarketViewController() -> BlackMarketViewController {
        let vc = BlackMarketViewController.instantiateMyViewController(name: .blackMarket)
        vc.presenter = BlackMarketPresenter(view: vc)
        return vc
    }
    
}

enum ViewControllerKeys : String {
    case blackMarket = "BlackMarket"
}
