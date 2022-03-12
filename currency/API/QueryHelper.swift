import Foundation

class QueryHelper {
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
}
