import Foundation


protocol BlackMarketAPILMP {
    func getBlackMarketData(complition : @escaping (BlackMarketModel?, Error?) -> Void)
}

class BlackMarketAPI : NSObject, BlackMarketAPILMP {
    
    func getBlackMarketData(complition: @escaping (BlackMarketModel?, Error?) -> Void) {
        serialQueue.async {
            apiSemaphore.wait()
            APIManager.jsonGetRequest(url: "----", returningType: BlackMarketModel.self) { model, error in
                if let model = model {
                    FileUtils.writeToFile(directoryName: directoryName, fileName: .blackMarcket, model: model)
                }
                apiSemaphore.signal()
                complition(model, error)
            }
        }
        
    }
    
}
