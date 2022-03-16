import UIKit


enum AppImage  {
    case dollarImage
    case euroImage
    case rubleImage
    case blackMarketIcon
    case banksIcon
    case bankIcon
    
    var image : UIImage {
        switch self {
        case .dollarImage: return UIImage(named: "dollarCoin")! 
        case .euroImage: return UIImage(named: "euroCoin")!
        case .rubleImage: return UIImage(named: "rubleCoin")!
        case .blackMarketIcon: return UIImage(named: "blackMarket_ic")!
        case .banksIcon: return UIImage(named: "banks_ic")!
        case .bankIcon: return PictureUtils.resizeImage(UIImage(named: "bankIcon")!, newWidth: 30, newHeight: 30)
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


enum MessagesText : String {
case error = "Something went wrong. Try later"
}
