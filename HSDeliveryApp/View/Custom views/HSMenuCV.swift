//
//  HSMenuCV.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxSwift

class HSMenuCV: UICollectionView {
    
    // MARK: -
    enum Section {
        case sale
        case menu
    }
    
    private let disposeBag = DisposeBag()
    private let menuViewModel = HSMenuViewModel()
    private var menuDiffableDataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private var menuCollectionLayout: UICollectionViewCompositionalLayout!
    
    // MARK: -
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
        configureLayout()
        configureDataSource()
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handle methods
    private func bind() {
        self.menuViewModel.fetchFood()
        self.menuViewModel.food.subscribe { viewModels in
            self.updateData(with: viewModels)
        } onError: { error in }.disposed(by: disposeBag)
    }
    
    private func updateData(with viewModels: [HSFoodViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([.sale, .menu])
        snapshot.appendItems(viewModels, toSection: .menu)
        
        DispatchQueue.main.async {
            self.menuDiffableDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: -
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.register(HSFoodCell.self, forCellWithReuseIdentifier: HSFoodCell.cellID)
        self.register(HSFoodCategoriesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HSFoodCategoriesHeader.cellID)
    }
    
    private func configureLayout() {
        menuCollectionLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            switch section {
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                header.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [header]
                
                return section
            default:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        })
        
        self.setCollectionViewLayout(menuCollectionLayout, animated: true)
    }
    
    private func configureDataSource() {
        menuDiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: self, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 1:
                guard let viewModel = itemIdentifier as? HSFoodViewModel else {
                    return UICollectionViewCell()
                }
                
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HSFoodCell.cellID, for: indexPath) as? HSFoodCell {
                    cell.viewModel = viewModel
                    
                    return cell
                }
            default:
                break
            }
            
            return UICollectionViewCell()
        })
        
        menuDiffableDataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            if let cell = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HSFoodCategoriesHeader.cellID, for: indexPath) as? HSFoodCategoriesHeader {
                return cell
            }
            return nil
        }
    }

}
