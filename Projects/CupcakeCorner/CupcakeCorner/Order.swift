//
//  Order.swift
//  CupcakeCorner
//
//  Created by Angela Garrovillas on 4/11/25.
//

import SwiftUI

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var hasValidAddress: Bool {
        if name.trimmed().isEmpty || streetAddress.trimmed().isEmpty || city.trimmed().isEmpty || zip.trimmed().isEmpty {
            return false
        }
        return true
    }
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var cost: Decimal {
        //$2 per cake
        var cost = Decimal(quantity) * 2
        
        //complicated cake costs more
        cost += Decimal(type) / 2
        
        //$1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        //$0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
}

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
