//
//  HSCategoryCell.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 14.10.2022.
//

import UIKit
import RxSwift

class HSCategoryCell: UICollectionViewCell {
    
    // MARK: - Parameters
    static let cellID = "HSCategoryCellID"
    private let disposeBag = DisposeBag()
    
    public var categoryString: String! {
        didSet {
            self.categoryTitleLabel.configureWith(text: categoryString.capitalized, fontSize: 16, fontWeight: .medium, textColor: .systemOrange)
        }
    }
    
    override var isSelected: Bool {
        didSet { didSelectionChanged() }
    }
    
    // MARK: - Views
    private let categoryTitleLabel = UILabel()
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureCategoryTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    private func didSelectionChanged() {
        switch isSelected {
        case true:
            UIView.animate(withDuration: 0.15, delay: 0) {
                self.layer.borderWidth  = 0
                self.backgroundColor    = .systemOrange.withAlphaComponent(0.13)
            }
        case false:
            UIView.animate(withDuration: 0.15, delay: 0) {
                self.layer.borderWidth  = 1
                self.backgroundColor    = .clear
            }
        }
    }
    
    // MARK: -
    private func configure() {
        self.layer.borderWidth  = 1
        self.layer.borderColor  = UIColor.systemOrange.withAlphaComponent(0.4).cgColor
        self.layer.cornerRadius = 20
    }
    
    private func configureCategoryTitleLabel() {
        self.addSubview(categoryTitleLabel)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            categoryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            categoryTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }
}
