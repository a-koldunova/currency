//
//  NationalBankModel.swift
//  currency
//
//  Created by Tanya Koldunova on 14.03.2022.
//

import Foundation

public struct NationalBankModel: Codable {
    public let r030: Int
    public let txt: String
    public let rate: Double
    public let cc: String
    public let exchangedate: String
}
