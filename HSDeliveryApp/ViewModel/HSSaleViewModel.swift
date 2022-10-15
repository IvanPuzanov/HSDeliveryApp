//
//  HSSaleViewModel.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxRelay

class HSSaleViewModel {
    
    // MARK: -
    private let id = UUID().uuidString
    
    public let image: BehaviorRelay<UIImage> = .init(value: UIImage(systemName: "photo.fill")!)
    
    // MARK: -
    init(sale: Sale) {
        DispatchQueue.global().async {
            guard let image = sale.image, let imageURL = URL(string: image) else { return }
            do {
                let imageData       = try Data(contentsOf: imageURL)
                let fetchedImage    = UIImage(data: imageData)
                
                guard let fetchedImage = fetchedImage else { return }
                self.image.accept(fetchedImage)
            } catch {}
        }
    }
    
}

extension HSSaleViewModel: Hashable {
    static func == (lhs: HSSaleViewModel, rhs: HSSaleViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) { }
}
