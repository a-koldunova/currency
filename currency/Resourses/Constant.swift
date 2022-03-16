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

enum MainImage {
    case bankIcon
    
    var image: UIImage {
        switch self {
        case .bankIcon: return PictureUtils.resizeImage(UIImage(named: "bankIcon")!, newWidth: 30, newHeight: 30)// UIImage(named: "bankIcon")!
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
