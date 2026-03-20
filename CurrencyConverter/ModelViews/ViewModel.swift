//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var rates: [String: Double] = [:]
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "EUR"
    
    private let api = CurrencyAPI()
    private let flagService = FlagService()
    
    var currencies: [String] {
        rates.keys.sorted()
    }
    
    //MARK: - Load Rates
    func loadRates() async {
        do {
            let response = try await api.fetchRates()
            rates = response.rates
            rates["USD"] = 1.0
        } catch {
            print("Error:", error)
        }
    }
    
    //MARK: - Swap
    func swapCurrencies() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
    }
    
    //MARK: - Convert
    func convert(amount: Double, from: String, to: String) -> Double? {
        guard let fromRate = rates[from],
              let toRate = rates[to] else {
            return nil
        }
        
        return amount * (toRate / fromRate)
    }
    
    //MARK: - Formatted Result
    func formattedResult(amount: String, from: String, to: String) -> String? {
        guard let value = Double(amount),
              let result = convert(amount: value, from: from, to: to) else {
            return nil
        }
        
        return String(format: "%.2f", result)
    }
    
    //MARK: - Flags
    func flag(for currency: String) -> String {
        flagService.flagEmoji(from: currency)
    }
    
    func flagURL(for currency: String) -> URL? {
        flagService.flagURL(from: currency)
    }
}
