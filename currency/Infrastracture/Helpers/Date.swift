//
//  Date.swift
//  currency
//
//  Created by Tanya Koldunova on 24.03.2022.
//

import Foundation

class DateHelper {
    
    class func differenceBtwNow(and dateStr: String)->TimeInterval{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from:dateStr)!
        return (date.timeIntervalSinceNow)
    }
    
    class func diffBtwNow(and ts: Double)->TimeInterval{
        let date = Date(timeIntervalSince1970: ts)
        return date.timeIntervalSinceNow
    }
    
}
