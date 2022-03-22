import Foundation
import UIKit

protocol IntroductionProtocol : SwiftMessagesManager {
    
}

protocol IntroductionPresenterProtocol : AnyObject {
    init(view : IntroductionProtocol)
    func goToTabbar()
}

class IntroductionPresenter : IntroductionPresenterProtocol {
   
    let view : IntroductionProtocol
    
    required init(view: IntroductionProtocol) {
        self.view  = view
    }
    
    func goToTabbar() {
        rootWindow?.rootViewController = Builder.resolveTabBar()
    }
    
}
