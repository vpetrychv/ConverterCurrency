//
//  Model.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import Foundation

struct RatesResponse: Codable {
   
       let base: String
       let date: String
       let rates: [String: Double]
    
}
