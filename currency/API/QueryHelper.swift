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
    
    func getBanksNearMe(lat: Double, lon: Double) -> [BankMapAnnotation] {
        let query = "SELECT BANK_NAME, ADDRESS, PHONE, LAT, LON  from BANK_VIEW  LEFT JOIN RATES on  RATES.BANK_ID = BANK_VIEW.BANK_ID  where abs(BANK_VIEW.LAT - ?) < 0.5 and abs(BANK_VIEW.LON - ?) < 0.5"
        var res = [BankMapAnnotation]()
        if let sql = db.executeQuery(query, withArgumentsIn: [lat, lon]) {
            while !sql.next() {
                res.append(BankMapAnnotation(bankName: sql.string(forColumn: "BANK_NAME")!, address: sql.string(forColumn: "ADDRESS")!, phone: sql.long(forColumn: "PHONE"), lat: sql.double(forColumn: "LAT"), lon: sql.double(forColumn: "LON"), curr: sql.string(forColumn: "CURR")!, buy: sql.double(forColumn: "BUY"), sell: sql.double(forColumn: "SELL")))
            }
        }
        return res
    }
    
    func insertRates(_ inputData: BanksModel) {
        db.executeUpdate("delete from RATES", withArgumentsIn: [])
        let query = "Insert INTO RATES (BANK_ID, CURR, BUY, SELL) VALUES (?, ?, ?, ?)"
        for i in inputData.usd {
            if !db.executeUpdate(query, withArgumentsIn: [i.id, "usd", i.b, i.s]){
            print(db.lastErrorMessage())
        }
        }
        for i in inputData.eur {
            if !db.executeUpdate(query, withArgumentsIn: [i.id, "eur", i.b, i.s]){
            print(db.lastErrorMessage())
        }
        }
        for i in inputData.rub {
            if !db.executeUpdate(query, withArgumentsIn: [i.id, "rub", i.b, i.s]){
            print(db.lastErrorMessage())
        }
        }
    }
}
