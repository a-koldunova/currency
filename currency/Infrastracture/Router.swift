import UIKit


protocol RouterProtocol {
    func goToCalculatorViewController(_ parentVC: UIViewController, buy : Double, sell : Double, title : String)
    func pushMapViewController(bankId: Int)
}

class Router: RouterProtocol {
    
    static let sharedInstance = Router()
    
    func goToCalculatorViewController(_ parentVC: UIViewController, buy : Double, sell : Double, title : String) {
        let vc = UINavigationController(rootViewController: Builder.resolveCalculatorViewController(buy: buy, sell: sell, title: title))
        vc.modalPresentationStyle = .popover
        parentVC.present(vc, animated: true, completion: nil)
    }
    
    func pushMapViewController(bankId: Int) {
        let vc = Builder.resolveBankMapPositionViewController(bankId: bankId)
        pushVc(vc)
    }
    
    func pushBlackMarket() {
        
    }
    
   private func pushVc(_ vc: UIViewController) {
        let currentVc = getTopViewController()
        currentVc?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getTopViewController(base: UIViewController? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return getTopViewController(base: nav.visibleViewController)

            } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
                return getTopViewController(base: selected)

            } else if let presented = base?.presentedViewController {
                return getTopViewController(base: presented)
            }
            return base
        }
    
}
