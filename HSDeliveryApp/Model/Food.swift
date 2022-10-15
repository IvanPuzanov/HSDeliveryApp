//
//  Pizza.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import Foundation

struct FoodDeliveryResult: Codable {
    var sale: [Sale]
    var food: [Food]
}

struct Food: Codable, Hashable {
    var category: String
    var name: String
    var description: String
    var price: Float
    var image: String?
}
