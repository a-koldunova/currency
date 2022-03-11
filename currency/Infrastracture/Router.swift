import UIKit


protocol RouterProtocol {
    
}

class Router: RouterProtocol {
    let sharedInstance = Router()
    
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
