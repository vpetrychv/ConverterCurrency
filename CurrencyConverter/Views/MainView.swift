//
//  MainView.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import SwiftUI

struct MainView: View {
    //MARK: - Propirties
    @StateObject var vm = ViewModel()
    @State private var amount = ""
    
    //MARK: - Body
    var body: some View {
        NavigationStack{
            ZStack{
                //Background Gradient
                LinearGradient(
                    colors: [Color.colorBackgroundOne, Color.colorDoBackgroundTwo],
                    startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                ///Content
                VStack{
                    //Text Field
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .font(.headline)
                        .padding()
                        .background(Color.color_Primary.opacity(0.15))
                        .cornerRadius(15)
                        .padding(6)
                        
                    Spacer()
                    
                    //MARK: - Picker
                    Picker("From", selection: $vm.fromCurrency) {
                        ForEach(vm.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }

                    Picker("To", selection: $vm.toCurrency) {
                        ForEach(vm.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    //MARK: - Buttun Swap
                    Button {
                        vm.swapCurrencies()
                    }label: {
                        Text("Press")
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    
                    Spacer()
                    
                    //MARK: - Result
                    if let result = vm.formattedResult(amount: amount, from: vm.fromCurrency, to: vm.toCurrency) {
                        Text("Result: \(result) \(vm.toCurrency)")
                    }
                }//vs
            }
            .navigationTitle("Currency Converter")
        }//NS
        //task
        .task {
            await vm.loadRates()
            if let first = vm.currencies.first {
                vm.fromCurrency = first
                vm.toCurrency = first
            }
        }
    }//body
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
