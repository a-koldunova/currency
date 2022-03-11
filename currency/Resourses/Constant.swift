import UIKit


enum CoinImage  {
    case dollarImage
    case euroImage
    case rubleImage
    
    var image : UIImage {
        switch self {
        case .dollarImage: return UIImage(named: "dollarCoin")!
        case .euroImage: return UIImage(named: "euroCoin")!
        case .rubleImage: return UIImage(named: "rubleCoin")!
        }
    }
}

