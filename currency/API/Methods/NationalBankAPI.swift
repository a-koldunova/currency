import Foundation

protocol NationalBankAPIProtocol: NSObject  {
    func getNationalBankModel(completion: @escaping ([NationalBankModel]?, Error?)->Void)
}

class NationalBankAPI: NSObject, NationalBankAPIProtocol {
    
    func getNationalBankModel(completion: @escaping ([NationalBankModel]?, Error?) -> Void) {
        APIManager.jsonGetRequest(url: "---", returningType: [NationalBankModel].self) { model, error in
            FileUtils.writeToFile(directoryName: directoryName, fileName: .nationalBank, model: model)
            completion(model, error)
        }
    }    
    
}
