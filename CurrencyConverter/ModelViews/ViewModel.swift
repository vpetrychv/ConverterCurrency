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
    //MARK: - Propirties
    @Published var rates: [String: Double] = [:]
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "EUR"
    
    private var api = CurrencyAPI()
    
    var currencies: [String] {
           rates.keys.sorted()
       }
    
    //MARK: - Loading Rates
    func loadRates() async {
        do {
            let response = try await api.fetchRates()
            
            rates = response.rates
            rates["USD"] = 1.0
            
        } catch {
            print("Error:", error)
        }
    }
    //MARK: -  Swaping Buttons Currencies
    func swapCurrencies() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
    }
    
    //MARK: - Formatted Result
    func formattedResult(amount: String, from: String, to: String) -> String? {
        guard let value = Double(amount),
              let result = convert(amount: value, from: from, to: to) else {
            return nil
        }
        
        return String(format: "%.2f", result)
    }
    
    //MARK: - Convert
    func convert(amount: Double, from: String, to: String) -> Double? {
        guard let fromRate = rates[from],
              let toRate = rates[to] else {
            return nil
        }

        return amount * (toRate / fromRate)
    }
}
