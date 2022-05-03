import Foundation

protocol BankMapPositionApiProtocol {
    init(queryHelper: QueryHelperProtocol)
    func getPositionModel(lat: Double, lon: Double, bankId: Int, completion: @escaping ([BankMapAnnotation])->Void)
}

class BankMapPositionAPI: BankMapPositionApiProtocol {
    var queryHelper: QueryHelperProtocol
    
    required init(queryHelper: QueryHelperProtocol) {
        self.queryHelper = queryHelper
    }
    
    func getPositionModel(lat: Double, lon: Double, bankId: Int, completion: @escaping ([BankMapAnnotation]) -> Void) {
        let res = queryHelper.getBankPosition(lat: lat, lon: lon, bankId: bankId)
        completion(res)
    }

}
