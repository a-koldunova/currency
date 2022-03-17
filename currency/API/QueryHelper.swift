import Foundation

protocol QueryHelperProtocol {
    func getBanksRatesData(curr: String) -> [BuySellModel]
    func getNameOfBank(by id: Int) -> String?
    func getLink(by id : Int) -> String?
    func insertRates(_ inputData: BanksModel) -> Bool
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
    
    func getBanksRatesData(curr: String) -> [BuySellModel] {
        let query = "SELECT BANK_ID, BUY, SELL FROM RATES WHERE CURR = ?"
        var res = [BuySellModel]()
        if let sql = db.executeQuery(query, withArgumentsIn: [curr]) {
            while sql.next() {
                res.append(BuySellModel(id: sql.long(forColumn: "BANK_ID"), b: sql.double(forColumn: "BUY"), s: sql.double(forColumn: "SELL")))
            }
        }
        return res
    }
    
    func getBanksNearMe(lat: Double, lon: Double) -> [BankMapAnnotation] {
        let query = "SELECT BANK_NAME, ADDRESS, PHONE, LAT, LON, group_concat(CURR || \"/\" || BUY || \"/\" || SELL) as RATES from BANK_VIEW  LEFT JOIN RATES on  RATES.BANK_ID = BANK_VIEW.BANK_ID  where abs(BANK_VIEW.LAT - ?) < 0.5 and abs(BANK_VIEW.LON - ?) < 0.5 and CURR is not null group BY  BANK_NAME, LAT, LON"
        var res = [BankMapAnnotation]()
        if let sql = db.executeQuery(query, withArgumentsIn: [lat, lon]) {
            while sql.next() {
                var rates = [ExchangeBankModel]()
                let curr = sql.string(forColumn: "RATES")!.components(separatedBy: ",")
                for c in curr {
                    let rate = c.components(separatedBy: "/")
                    rates.append(ExchangeBankModel(name: rate[0], b: rate[1], s: rate[2]))
                }
               
                res.append(BankMapAnnotation(bankName: sql.string(forColumn: "BANK_NAME")!, address: sql.string(forColumn: "ADDRESS")!, phone: sql.long(forColumn: "PHONE"), lat: sql.double(forColumn: "LAT"), lon: sql.double(forColumn: "LON"), exchangeModel: rates))
               
            }
            sql.close()
        }
        return res
    }
    
    func getBankPosition(lat: Double, lon: Double, bankId: Int) -> [BankMapAnnotation] {
        let query = "SELECT BANK_NAME, ADDRESS, PHONE, LAT, LON, group_concat(CURR || \"/\" || BUY || \"/\" || SELL) as RATES from BANK_VIEW LEFT JOIN RATES on  RATES.BANK_ID = BANK_VIEW.BANK_ID where  BANK_VIEW.BANK_ID = ? and abs(BANK_VIEW.LAT - 46.482952) < 0.5 and abs(BANK_VIEW.LON - 30.712481) < 0.5 and CURR is not null group BY  BANK_NAME, LAT, LON"
        var res = [BankMapAnnotation]()
        if let sql = db.executeQuery(query, withArgumentsIn: [lat, lon]) {
            while sql.next() {
                var rates = [ExchangeBankModel]()
                let curr = sql.string(forColumn: "RATES")!.components(separatedBy: ",")
                for c in curr {
                    let rate = c.components(separatedBy: "/")
                    rates.append(ExchangeBankModel(name: rate[0], b: rate[1], s: rate[2]))
                }
               
                res.append(BankMapAnnotation(bankName: sql.string(forColumn: "BANK_NAME")!, address: sql.string(forColumn: "ADDRESS")!, phone: sql.long(forColumn: "PHONE"), lat: sql.double(forColumn: "LAT"), lon: sql.double(forColumn: "LON"), exchangeModel: rates))
            }
            sql.close()
        }
        return res
    }
    
    func insertRates(_ inputData: BanksModel) -> Bool {
        db.executeUpdate("delete from RATES", withArgumentsIn: [])
        var res = false
        let query = "Insert INTO RATES (BANK_ID, CURR, BUY, SELL) VALUES (?, ?, ?, ?)"
        for i in inputData.usd {
            if db.executeUpdate(query, withArgumentsIn: [i.id, "usd", i.b, i.s]){
            res = true
        }
        }
        for i in inputData.eur {
            if db.executeUpdate(query, withArgumentsIn: [i.id, "eur", i.b, i.s]){
            res = true
        }
        }
        for i in inputData.rub {
            if db.executeUpdate(query, withArgumentsIn: [i.id, "rub", i.b, i.s]){
            res = true
        }
        }
        return res
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
