//
//  HSFoodCelll.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxSwift

class HSFoodCell: UICollectionViewCell {
    
    // MARK: - Parameters
    static let cellID = "HSFoodCellID"
    private let disposeBag = DisposeBag()
    
    public var viewModel: HSFoodViewModel! {
        didSet {
            self.foodTitleLabel.configureWith(text: viewModel.title, fontSize: 18, fontWeight: .semibold)
            self.foodDescriptionLabel.configureWith(text: viewModel.description, fontSize: 15, fontWeight: .regular, textColor: .secondaryLabel)
            self.priceButton.configureWith(title: "от \(viewModel.price) ₽", fontSize: 15, fontWeight: .regular, color: .systemOrange)
            
            self.viewModel.image.subscribe { image in
                DispatchQueue.main.async {
                    self.foodImageView.image = image
                }
            } onError: { _ in }.disposed(by: disposeBag)

        }
    }
    
    // MARK: - Views
    private let mainStackView           = UIStackView()
    private let foodImageView           = UIImageView()
    
    private let titlesStackView         = UIStackView()
    private let foodTitleLabel          = UILabel()
    private let foodDescriptionLabel    = UILabel()
    private let foodPriceLabel          = UILabel()
    private let priceButton             = UIButton()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configurMainStackView()
        configureFoodImageView()
        configureTitlesStackView()
        configureFoodTitleLabel()
        configureFoodDescriptionLabel()
        configurePriceButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configure() {
        self.backgroundColor = .systemBackground
    }
    
    private func configurMainStackView() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.axis = .horizontal
        mainStackView.spacing = 15
        mainStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func configureFoodImageView() {
        self.mainStackView.addArrangedSubview(foodImageView)
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        foodImageView.image         = UIImage(systemName: "photo.fill")
        foodImageView.tintColor     = .quaternarySystemFill
        foodImageView.contentMode   = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(equalToConstant: 150),
            foodImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureTitlesStackView() {
        self.mainStackView.addArrangedSubview(titlesStackView)
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titlesStackView.axis = .vertical
        titlesStackView.alignment = .trailing
    }
    
    private func configureFoodTitleLabel() {
        self.titlesStackView.addArrangedSubview(foodTitleLabel)
        
        foodTitleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            self.foodTitleLabel.leadingAnchor.constraint(equalTo: titlesStackView.leadingAnchor),
            self.foodTitleLabel.trailingAnchor.constraint(equalTo: titlesStackView.trailingAnchor)
        ])
    }
    
    private func configureFoodDescriptionLabel() {
        self.titlesStackView.addArrangedSubview(foodDescriptionLabel)
        self.titlesStackView.setCustomSpacing(8, after: foodTitleLabel)
        
        self.foodDescriptionLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            self.foodDescriptionLabel.leadingAnchor.constraint(equalTo: titlesStackView.leadingAnchor),
            self.foodDescriptionLabel.trailingAnchor.constraint(equalTo: titlesStackView.trailingAnchor)
        ])
    }
    
    private func configurePriceButton() {
        self.titlesStackView.addArrangedSubview(priceButton)
        self.titlesStackView.setCustomSpacing(15, after: foodDescriptionLabel)
        
        self.priceButton.translatesAutoresizingMaskIntoConstraints = false
        self.priceButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
