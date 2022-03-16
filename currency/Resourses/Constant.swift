import UIKit


enum AppImage  {
    case dollarImage
    case euroImage
    case rubleImage
    case blackMarketIcon
    case banksIcon
    
    var image : UIImage {
        switch self {
        case .dollarImage: return UIImage(named: "dollarCoin")!
        case .euroImage: return UIImage(named: "euroCoin")!
        case .rubleImage: return UIImage(named: "rubleCoin")!
        case .blackMarketIcon: return UIImage(named: "blackMarket_ic")!
        case .banksIcon: return UIImage(named: "banks_ic")!
        }
    }
}


enum MessagesText : String {
case error = "Something went wrong. Try later"
}
