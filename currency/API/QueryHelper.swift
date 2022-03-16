import Foundation

protocol QueryHelperProtocol {
    func getNameOfBank(by id: Int) -> String?
    func getLink(by id : Int) -> String?
}

class QueryHelper : QueryHelperProtocol {
    public static var shared = QueryHelper()
    let db = DBManager.sharedInstance.db!
    
    func getNameOfBank(by id: Int) -> String? {
        let query = "SELECT BANK_NAME FROM BANKS WHERE F_ID = " + id.description
        if let sql = db.executeQuery(query, withArgumentsIn: []) {
            if sql.next() {
                return sql.string(forColumn: "BANK_NAME")!
            }
            sql.close()
        }
        return nil
    }
    
    func getLink(by id : Int) -> String? {
        let query = "SELECT WWW FROM BANKS WHERE F_ID = " + id.description
        if let sql = db.executeQuery(query, withArgumentsIn: []) {
            if sql.next() {
                return sql.string(forColumn: "WWW")!
            }
            sql.close()
        }
        return nil
    }
}
