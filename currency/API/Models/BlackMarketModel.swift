import Foundation

struct BlackMarketModel : Codable {
    public let UAHrates : [CurrencyModel]
    public let forecast : Int
    public let time : Int
}

struct CurrencyModel : Codable {
    public let buy : Double
    public let sell : Double
}
