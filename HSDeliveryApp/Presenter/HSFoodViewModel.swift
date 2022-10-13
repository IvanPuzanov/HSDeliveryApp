//
//  HSFoodViewModel.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

class HSFoodViewModel {
    
    // MARK: -
    private let id = UUID().uuidString
    
    public var title: String
    public var description: String
    public var category: String
    
    // MARK: -
    init(food: Food) {
        self.title          = food.name
        self.description    = food.description
        self.category       = food.category
    }
}

extension HSFoodViewModel: Hashable {
    static func == (lhs: HSFoodViewModel, rhs: HSFoodViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) { }
}
