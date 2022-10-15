//
//  ViewController.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit

class MainVC: UIViewController {

    // MARK: -
    private let menuCollectionView = HSMenuCV(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureCollectionView()
    }
    
    // MARK: -
    private func configure() {
        self.view.backgroundColor = .systemBackground
        
        self.navigationController?.navigationBar.shadowImage        = UIImage()
        self.navigationController?.navigationBar.barTintColor       = .systemBackground
        self.navigationController?.navigationBar.backgroundColor    = .systemBackground
    }
    
    private func configureCollectionView() {
        self.view.addSubview(menuCollectionView)
        
        NSLayoutConstraint.activate([
            menuCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
