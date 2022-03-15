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

enum MainColors {
    case fontColor
    
    var color: UIColor {
        switch self {
        case .fontColor: return UIColor(named: "fontColor")!
        }
    }
}

enum MainImage {
    case bankIcon
    
    var image: UIImage {
        switch self {
        case .bankIcon: return UIImage(named: "bankIcon")!
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
