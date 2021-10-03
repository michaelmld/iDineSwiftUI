//
//  CheckoutView.swift
//  DrDogSwiftUi
//
//  Created by michael dang on 10/3/21.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    //This data is just for our view. so use @State and mark it private
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    let tipAmounts = [10, 15, 20, 25, 0]
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0 "
    }
    
    var body: some View {
        Form {
            Section {
                //What does $ do?
                //Provide 2 way binding to the data
                Picker("How do you want to pay?", selection: $paymentType) {
                    //Dynamic data needs a self identifier?
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                
                //Not $ here, casue its only a READ not a READ/Write
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker("Percentage", selection: $tipAmount) {
                    //Dynamic data needs a self identifier?
                    ForEach(tipAmounts, id: \.self) {
                        Text("$\($0)")
                    }
                }.pickerStyle(.segmented)
            }
            
            Section(header: Text("TOTAL: \(totalPrice)").font(.largeTitle)) {
                Button("Confirm order"){
                    showingPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was \(totalPrice)"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
