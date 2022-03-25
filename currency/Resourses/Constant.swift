import UIKit

public var rootWindow: UIWindow?

var directoryName = "currency"

var isViewShown: Bool {
    set {
        UserDefaults.standard.set(!newValue, forKey: UserDefaultsKeys.isViewShown.rawValue)
    }
    get {
        return !UserDefaults.standard.bool(forKey: UserDefaultsKeys.isViewShown.rawValue)
    }
}

enum UserDefaultsKeys : String {
    case isViewShown = "IS_VIEW_SHOWN"
    case isfirstLaunch = "IS_FIRST_LAUCN"
}

enum FileNames: String {
    case blackMarcket = "blackMarcket.txt"
    case nationalBank = "nationalBank.txt"
}

enum AppImage  {
    case dollarImage
    case euroImage
    case rubleImage
    case blackMarketIcon
    case banksIcon
    case bankIcon
    case nationakBankIcon
    case nearMeIcon
    
    var image : UIImage {
        switch self {
        case .dollarImage: return UIImage(named: "dollarCoin")! 
        case .euroImage: return UIImage(named: "euroCoin")!
        case .rubleImage: return UIImage(named: "rubleCoin")!
        case .blackMarketIcon: return UIImage(named: "blackMarket_ic")!
        case .banksIcon: return UIImage(named: "banks_ic")!
        case .bankIcon: return UIImage(named: "bankIcon")!
        case .nationakBankIcon: return UIImage(named: "nationalBank_ic")!
        case .nearMeIcon: return UIImage(named: "nearMe_ic")!
        
        }
    }
}

enum MainColors {
    case fontColor
    case bottomSheetColor
    case selectedColor
    
    var color: UIColor {
        switch self {
        case .fontColor: return UIColor(named: "fontColor")!
        case .bottomSheetColor: return UIColor(named: "bottomSheetColor")!
        case .selectedColor: return UIColor(named: "selectedColor")!
        }
    }
}


enum NavigationTitle {
    case blackMarcket
    case banks
    case nationalBank
    
    var title: String {
        switch self {
        case .blackMarcket: return "Black Marcket"
        case .banks: return "Banks"
        case .nationalBank: return "National Banks"
        }
    }
}

enum Currency: String {
    case usd = "usd"
    case eur = "eur"
    case rub = "rub"
}


enum MessagesText : String {
case error = "Something went wrong. Try later"
}
