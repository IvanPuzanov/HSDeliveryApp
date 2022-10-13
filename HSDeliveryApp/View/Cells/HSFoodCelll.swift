//
//  HSFoodCelll.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

class HSFoodCelll: UICollectionViewCell {
    
    // MARK: - Views
    private let foodImageView           = UIImageView()
    
    private let titlesStackView         = UIStackView()
    private let foodTitleLabel          = UILabel()
    private let foodDescriptionLabel    = UILabel()
    private let foodPriceLabel          = UILabel()
    
    // MARK: - Initialization
    
    // MARK: - Configuration
    private func configure() {
        self.backgroundColor = .systemBackground
    }
}
