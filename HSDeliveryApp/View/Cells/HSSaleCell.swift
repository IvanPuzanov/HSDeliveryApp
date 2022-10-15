//
//  HSSaleCell.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxSwift

class HSSaleCell: UICollectionViewCell {
    
    // MARK: - Parameters
    static let cellID = "HSSaleCellID"
    private let disposeBag = DisposeBag()
    
    public var viewModel: HSSaleViewModel! {
        didSet {
            viewModel.image.subscribe { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } onError: { _ in }.disposed(by: disposeBag)
        }
    }
    
    // MARK: - Views
    private let imageView = UIImageView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure() {
        self.layer.cornerRadius = 18
        self.layer.cornerCurve  = .continuous
        
        self.clipsToBounds = true
    }
    
    private func configureImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor     = .quaternarySystemFill
        imageView.contentMode   = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
