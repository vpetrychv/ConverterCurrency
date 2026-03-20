//
//  MainView.swift
//  CurrencyConverter
//
//  Created by Vasyl Petrych on 17/03/2026.
//

import SwiftUI

struct MainView: View {
    //MARK: - Properties
    @StateObject var vm = ViewModel()
    @State private var amount = ""
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: [Color.colorBackgroundOne, Color.colorDoBackgroundTwo],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    Text("Check live rates, set rate alerts, receive\n notifications and more")
                        .multilineTextAlignment(.center)
                    
                    //MARK: - Amount
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .font(.headline)
                        .padding()
                        .background(Color.color_Primary.opacity(0.15))
                        .cornerRadius(15)
                        .padding(6)
                    
                    //MARK: - FROM
                    NavigationLink {
                        currencyListView(selected: $vm.fromCurrency, title: "From")
                    } label: {
                        pickerRow(title: "From", value: vm.fromCurrency)
                    }
                    
                    //MARK: - TO
                    NavigationLink {
                        currencyListView(selected: $vm.toCurrency, title: "To")
                    } label: {
                        pickerRow(title: "To", value: vm.toCurrency)
                    }
                    
                    Spacer()
                    
                    //MARK: - Swap
                    Button {
                        vm.swapCurrencies()
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    .buttonStyle(GrowingButton())
                    
                    Spacer()
                    
                    //MARK: - Result
                    if let result = vm.formattedResult(amount: amount, from: vm.fromCurrency, to: vm.toCurrency) {
                        Text("Result: \(result) \(vm.flag(for: vm.toCurrency)) \(vm.toCurrency)")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Currency Converter")
        }
        .task {
            await vm.loadRates()
            if let first = vm.currencies.first {
                vm.fromCurrency = first
                vm.toCurrency = first
            }
        }
    }
}

//MARK: - Picker Row
extension MainView {
    
    func pickerRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(vm.flag(for: value)) \(value)")
                .foregroundStyle(.secondary)
        }
        .font(.headline)
        .padding()
        .background(Color.color_Primary.opacity(0.15))
        .cornerRadius(15)
        .padding(6)
    }
}

//MARK: - Currency List
extension MainView {
    
    func currencyListView(selected: Binding<String>, title: String) -> some View {
        List(vm.currencies, id: \.self) { currency in
            
            Button {
                selected.wrappedValue = currency
            } label: {
                HStack(spacing: 12) {
                    
                    Text("\(vm.flag(for: currency)) \(currency)")
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    if currency == selected.wrappedValue {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle(title)
    }
}

//MARK: - Button Style
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.blue, Color.colorSystemTeal],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 2.4 : 2)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
