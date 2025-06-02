//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Angela Garrovillas on 4/11/25.
//

import SwiftUI

struct Address: Codable {
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
}

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            .onAppear(perform: loadAddress)
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                        .onAppear(perform: saveAddress)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    func saveAddress() {
        let address = Address(name: order.name, streetAddress: order.streetAddress, city: order.city, zip: order.zip)
        if let encoded = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encoded, forKey: "Address")
        }
    }
    func loadAddress() {
        if let savedItems = UserDefaults.standard.data(forKey: "Address") {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedItems) {
                order.name = decodedAddress.name
                order.streetAddress = decodedAddress.streetAddress
                order.city = decodedAddress.city
                order.zip = decodedAddress.zip
                return
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}
