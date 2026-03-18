//
//  CurrencyAPI.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import Foundation

class CurrencyAPI {
    
    func fetchRates() async  throws -> RatesResponse {
        
        guard let url = URL(string: "https://api.exchangerate-api.com/v4/latest/USD") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(RatesResponse.self, from: data)
        
        return decoded
    }
}
