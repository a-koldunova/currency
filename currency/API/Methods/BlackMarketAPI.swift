import Foundation


protocol BlackMarketAPILMP {
    func getBlackMarketData(complition : @escaping (BlackMarketModel?, Error?) -> Void)
}

class BlackMarketAPI : APIManager, BlackMarketAPILMP {
    
    func getBlackMarketData(complition: @escaping (BlackMarketModel?, Error?) -> Void) {
        jsonGetRequest(url: "https://infoship.xyz/curr/uah.php?cli=9", returningType: BlackMarketModel.self) { model, error in
            complition(model, error)
        }
    }
    
}
