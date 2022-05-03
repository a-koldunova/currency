import UIKit


class MainTabBarController: UITabBarController {
    
    var presenter: MainTabBarPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        FileUtils.createDirectory(directoryName)
        configureTabBarController()
        UserDefaultsValues.isFirstLaunch = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getBankData()
    }
    
    func configureTabBarController() {
        
        if #available(iOS 15, *) {
            let appearence = UITabBarAppearance()
            appearence.configureWithOpaqueBackground()
            appearence.backgroundColor = UIColor(red: 0.875, green: 1, blue: 0.879, alpha: 1)
            setTabBarItemColors(appearence.stackedLayoutAppearance)
            setTabBarItemColors(appearence.compactInlineLayoutAppearance)
            setTabBarItemColors(appearence.inlineLayoutAppearance)
            self.tabBar.standardAppearance = appearence
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        } else {
            self.tabBar.barTintColor = UIColor(red: 0.875, green: 1, blue: 0.879, alpha: 1)
            self.tabBar.unselectedItemTintColor = UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)
            self.tabBar.tintColor = .green
        }
        
        let vcList = getControllers()
        
        self.setViewControllers(vcList, animated: true)
    }
    
    func getControllers() -> [UIViewController] {
        var vcList = [UIViewController]()
        let firstVC = UINavigationController(rootViewController: Builder.resolveBlackMarketViewController())
        firstVC.tabBarItem = UITabBarItem(title: L10n.TabBar.Item.BlackMarket.title, image: AppImage.blackMarketIcon.image, tag: 0)
        vcList.append(firstVC)
        //         secondVC
        let secondVC = UINavigationController(rootViewController: Builder.resolveBanksViewController())
        secondVC.tabBarItem = UITabBarItem(title: L10n.TabBar.Item.Banks.title, image: AppImage.banksIcon.image, tag: 1)
        vcList.append(secondVC)
        
        let thirdVC = UINavigationController(rootViewController: Builder.resolveNationalBankViewController())
        thirdVC.tabBarItem = UITabBarItem(title: L10n.TabBar.Item.NatBank.title, image: AppImage.nationakBankIcon.image, tag: 2)
        vcList.append(thirdVC)
        
        let fourthVC = UINavigationController(rootViewController: Builder.resolveBankMapViewController())
        fourthVC.tabBarItem = UITabBarItem(title: L10n.TabBar.Item.Near.title, image: AppImage.nearMeIcon.image, tag: 3)
        vcList.append(fourthVC)
        return vcList
    }
    
    func setTabBarItemColors( _ itemAppearence: UITabBarItemAppearance) {
        itemAppearence.selected.titleTextAttributes = [.foregroundColor : UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)]
        itemAppearence.selected.iconColor = UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)
        itemAppearence.normal.titleTextAttributes = [.foregroundColor : UIColor(red: 0.529, green: 0.78, blue: 0.306, alpha: 1)]
        itemAppearence.normal.iconColor = UIColor(red: 0.529, green: 0.78, blue: 0.306, alpha: 1)
    }
    
    
    
   
    
}

extension MainTabBarController: MainTabBarViewProtocol {
    func getTabBar() -> UITabBar {
        return self.tabBar
    }
    
    
}
