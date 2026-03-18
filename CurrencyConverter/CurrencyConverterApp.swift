//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    //MARK: - Propirties
    @AppStorage("isDarkMode") private var isDarkMode = true
    @StateObject var vm = ViewModel()
    
    //MARK: - Body
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
