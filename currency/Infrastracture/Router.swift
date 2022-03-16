import UIKit


protocol RouterProtocol {
    func goToCalculatorViewController(parentVC : UIViewController)
}

class Router: RouterProtocol {
    
    static let sharedInstance = Router()
    
    func goToCalculatorViewController(parentVC: UIViewController) {
        let vc = Builder.resolveCalculatorViewController()
        vc.modalPresentationStyle = .popover
        parentVC.present(vc, animated: true, completion: nil)
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
