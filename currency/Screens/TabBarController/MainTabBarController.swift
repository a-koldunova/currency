import UIKit


class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
    }
    
    func configureTabBarController() {
        var vcList = [UIViewController]()
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
        let firstVC = UINavigationController(rootViewController: Builder.resolveBlackMarketViewController())
        firstVC.tabBarItem = UITabBarItem(title: "Black Market", image: AppImage.blackMarketIcon.image, tag: 0)
        vcList.append(firstVC)
        //         secondVC
        let secondVC = UINavigationController(rootViewController: Builder.resolveBanksViewController())
        secondVC.tabBarItem = UITabBarItem(title: "Banks", image: AppImage.banksIcon.image, tag: 1)
        vcList.append(secondVC)
        
        self.setViewControllers(vcList, animated: true)
    }
    
    func setTabBarItemColors( _ itemAppearence: UITabBarItemAppearance) {
        itemAppearence.selected.titleTextAttributes = [.foregroundColor : UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)]
        itemAppearence.selected.iconColor = UIColor(red: 0.533, green: 0.6, blue: 0.49, alpha: 1)
        itemAppearence.normal.titleTextAttributes = [.foregroundColor : UIColor(red: 0.529, green: 0.78, blue: 0.306, alpha: 1)]
        itemAppearence.normal.iconColor = UIColor(red: 0.529, green: 0.78, blue: 0.306, alpha: 1)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
