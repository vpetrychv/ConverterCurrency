//
//  Model.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import Foundation

//MARK: - API Currency Responce
struct RatesResponse: Codable {
       let base: String
       let date: String
       let rates: [String: Double]
    
}

//MARK: - Flag Service
struct FlagService {
    func countryCode(from currency: String) -> String {
        let map: [String: String] = [
            "EUR": "eu",
            "USD": "us",
            "GBP": "gb",
            "UAH": "ua",
            "CHF": "ch",
            "JPY": "jp",
            "AUD": "au",
            "CAD": "ca",
            "CNY": "cn",
            "SEK": "se",
            "NOK": "no",
            "DKK": "dk",
            "PLN": "pl",
            "CZK": "cz",
            "HUF": "hu",
            "RON": "ro",
            "BGN": "bg",
            "TRY": "tr",
            "INR": "in",
            "BRL": "br",
            "ZAR": "za",
            "MXN": "mx",
            "KRW": "kr",
            "SGD": "sg",
            "HKD": "hk",
            "NZD": "nz",
            "ANG": "cw",
            "XAF": "cm",
            "XCD": "ag",
            "XCG": "ag",
            "XDR": "un",
            "XOF": "sn", 
            "XPF": "pf"
        ]
        
        return map[currency] ?? String(currency.prefix(2)).lowercased()
    }
    
    func flagEmoji(from currency: String) -> String {
        let code = countryCode(from: currency)
        let base: UInt32 = 127397
        var scalarString = ""
        
        for v in code.uppercased().unicodeScalars {
            if let scalar = UnicodeScalar(base + v.value) {
                scalarString.unicodeScalars.append(scalar)
            }
        }
        
        return scalarString
    }
    
    func flagURL(from currency: String) -> URL? {
        let code = countryCode(from: currency)
        return URL(string: "https://flagcdn.com/w40/\(code).png")
    }
}
