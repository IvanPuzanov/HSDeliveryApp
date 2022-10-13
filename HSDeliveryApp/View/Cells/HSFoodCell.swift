//
//  HSFoodCelll.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

class HSFoodCell: UICollectionViewCell {
    
    // MARK: - Parameters
    static let cellID = "HSFoodCellID"
    
    public var viewModel: HSFoodViewModel! {
        didSet {
            self.foodTitleLabel.text        = viewModel.title
            self.foodDescriptionLabel.text  = viewModel.description
        }
    }
    
    // MARK: - Views
    private let foodImageView           = UIImageView()
    
    private let titlesStackView         = UIStackView()
    private let foodTitleLabel          = UILabel()
    private let foodDescriptionLabel    = UILabel()
    private let foodPriceLabel          = UILabel()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureFoodImageView()
        configureTitlesStackView()
        configureFoodTitleLabel()
        configureFoodDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configure() {
        self.backgroundColor = .systemBackground
    }
    
    private func configureFoodImageView() {
        self.addSubview(foodImageView)
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        foodImageView.image         = UIImage(systemName: "photo.fill")
        foodImageView.tintColor     = .quaternarySystemFill
        foodImageView.contentMode   = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            foodImageView.widthAnchor.constraint(equalToConstant: 100),
            foodImageView.heightAnchor.constraint(equalToConstant: 100),
            foodImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            foodImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func configureTitlesStackView() {
        self.addSubview(titlesStackView)
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titlesStackView.axis = .vertical
        titlesStackView.alignment = .top
        
        NSLayoutConstraint.activate([
            titlesStackView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 15),
            titlesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titlesStackView.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor)
        ])
    }
    
    private func configureFoodTitleLabel() {
        self.titlesStackView.addArrangedSubview(foodTitleLabel)
    }
    
    private func configureFoodDescriptionLabel() {
        self.titlesStackView.addArrangedSubview(foodDescriptionLabel)
    }
}
