import Foundation


protocol BlackMarketAPILMP {
    func getBlackMarketData(complition : @escaping (BlackMarketModel?, Error?) -> Void)
}

class BlackMarketAPI : NSObject, BlackMarketAPILMP {
    
    func getBlackMarketData(complition: @escaping (BlackMarketModel?, Error?) -> Void) {
        APIManager.jsonGetRequest(url: "https://infoship.xyz/curr/uah.php?cli=9", returningType: BlackMarketModel.self) { model, error in
            FileUtils.writeToFile(directoryName: directoryName, fileName: .blackMarcket, model: model)
            complition(model, error)
        }
    }
    
}
