//
//  HSFoodCategoriesHeader.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

class HSFoodCategoriesHeader: UICollectionReusableView {
        
    // MARK: - Parameters
    static let cellID = "HSFoodCategoryHeader"
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    private func configure() {
        self.backgroundColor = .systemRed
    }
}
