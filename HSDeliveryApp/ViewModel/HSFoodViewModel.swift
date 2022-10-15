//
//  HSFoodViewModel.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxRelay

class HSFoodViewModel {
    
    // MARK: -
    private let id = UUID().uuidString
    
    public var title: String
    public var description: String
    public var category: String
    public var price: Float
    public var image: BehaviorRelay<UIImage> = .init(value: UIImage(systemName: "photo.fill")!)
    
    // MARK: -
    init(food: Food) {
        self.title          = food.name
        self.description    = food.description
        self.category       = food.category
        self.price          = food.price
        
        DispatchQueue.global(qos: .background).async {
            guard let image = food.image, let imageURL = URL(string: image) else { return }
            do {
                let imageData       = try Data(contentsOf: imageURL)
                let fetchedImage    = UIImage(data: imageData)
                
                guard let fetchedImage = fetchedImage else { return }
                self.image.accept(fetchedImage)
            } catch {}
        }
    }
}

extension HSFoodViewModel: Hashable {
    static func == (lhs: HSFoodViewModel, rhs: HSFoodViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) { }
}
