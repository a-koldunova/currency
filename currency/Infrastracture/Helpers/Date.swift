//
//  Date.swift
//  currency
//
//  Created by Tanya Koldunova on 24.03.2022.
//

import Foundation

class DateHelper {
    
    class func differenceBtwNow(){
        var s = "24.03.2022"
        let dateMaker=DateFormatter()
        dateMaker.locale=Locale(identifier: "US")
        dateMaker.timeZone = .current
        dateMaker.dateFormat="dd.MM.yyyy"
        if let dd=dateMaker.date(from: s){
            print(dd)
            print(Date())
            dateMaker.dateFormat="yyyy-MM-dd HH:mm"
            print (dateMaker.string(from: dd))
            print (dateMaker.string(from: Date()))
            print (dd.timeIntervalSinceNow)
        }
    }
    
    class func diffBtwNow(and ts: Double)->TimeInterval{
        let date = Date(timeIntervalSince1970: ts)
        return date.timeIntervalSinceNow
    }
    
}
