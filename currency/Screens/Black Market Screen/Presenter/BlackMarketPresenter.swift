import Foundation

protocol BlackMarketProtocol : AnyObject {
    
}

protocol BlackMarketPresenterProtocol : AnyObject {
    init(view : BlackMarketProtocol)
}

class BlackMarketPresenter : BlackMarketPresenterProtocol {
    
    let view : BlackMarketProtocol
    
    required init(view: BlackMarketProtocol) {
        self.view = view
    }
    
    
}

