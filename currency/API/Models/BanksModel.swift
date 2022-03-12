import Foundation

struct BanksModel: Codable {
    let ts: Int
    let usd: [BuySellModel]
    let eur: [BuySellModel]
    let rub: [BuySellModel]
}

struct BuySellModel: Codable {
    let id: Int
    let b: Double
    let s: Double
}

struct ExchangeBankModel: Codable {
    let name: String
    let b: String
    let s: String
}
