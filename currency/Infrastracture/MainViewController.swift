import UIKit


protocol MainViewProtocol {
    static func instantiateMyViewController(name: String) -> Self
}


class MainViewController<T>: UIViewController, MainViewProtocol {
    
    var presenter : T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                              .font: UIFont(name: "Cabin-Regular", size: 16)]
            appearance.backgroundColor = UIColor(named: "navigationBarColor")
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.barTintColor = UIColor(named: "navigationBarColor")
        }
    }
    
    static func instantiateMyViewController(name: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! Self
        return vc
    }
}
