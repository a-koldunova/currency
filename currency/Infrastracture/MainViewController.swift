import UIKit


protocol MainViewProtocol {
    static func instantiateMyViewController(name: ViewControllerKeys) -> Self
    func initRefreshControl()
}

class MainViewController<T>: UIViewController, MainViewProtocol {
    
    var presenter : T!
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1),
                                              .font: UIFont(name: "Cabin-Regular", size: 16),
                                              .kern : 1.5]
            appearance.backgroundColor = UIColor(named: "navigationBarColor")
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            
        } else {
            navigationController?.navigationBar.barTintColor = UIColor(named: "navigationBarColor")
        }
        navigationController?.navigationBar.tintColor = UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)
    }
    
    static func instantiateMyViewController(name: ViewControllerKeys) -> Self {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name.rawValue) as! Self
        return vc
    }
    
    func initRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.tintColor = UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)
    }
}
