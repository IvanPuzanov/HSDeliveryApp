//
//  HSMenuCV.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxSwift

enum Section: Int, CaseIterable {
    case sale
    case food
}

class HSMenuCV: UICollectionView {
    
    // MARK: -
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
        
        self.menuViewModel.sales.subscribe { salesViewModels in
            self.updateData(with: self.menuViewModel.createSnaphot())
        } onError: { _ in }.disposed(by: disposeBag)
        
        self.menuViewModel.food.subscribe { foodViewModels in
            self.updateData(with: self.menuViewModel.createSnaphot())
        } onError: { error in }.disposed(by: disposeBag)
        
        self.menuViewModel.selectedCategory.subscribe { category in
            if let indexPath = self.menuDiffableDataSource.indexPath(for: self.menuViewModel.getItemForSelectedCategory()) {
                self.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        } onError: { _ in }.disposed(by: disposeBag)

    }
    
    private func updateData(with snapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable>) {
        DispatchQueue.main.async {
            self.menuDiffableDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: -
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.register(HSSaleCell.self, forCellWithReuseIdentifier: HSSaleCell.cellID)
        self.register(HSFoodCell.self, forCellWithReuseIdentifier: HSFoodCell.cellID)
        self.register(HSFoodCategoriesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HSFoodCategoriesHeader.cellID)
    }
    
    private func configureLayout() {
        menuCollectionLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            switch section {
            case 0:
                do {
                    let sales = try self.menuViewModel.sales.value()
                    
                    switch sales.isEmpty {
                    case true:
                        return self.configureFoodLayout()
                    case false:
                        return self.configureSaleLayout()
                    }
                } catch {
                    return self.configureDefaultSectionLayout()
                }
            case 1:
                return self.configureFoodLayout()
            default:
                return self.configureDefaultSectionLayout()
            }
        })
        
        self.setCollectionViewLayout(menuCollectionLayout, animated: true)
    }
    
    private func configureDataSource() {
        menuDiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: self, cellProvider: { collectionView, indexPath, item in
            
            if let saleViewModel = item as? HSSaleViewModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HSSaleCell.cellID, for: indexPath) as? HSSaleCell else {
                    return UICollectionViewCell()
                }
                cell.viewModel = saleViewModel
                return cell
            }
            
            if let foodViewModel = item as? HSFoodViewModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HSFoodCell.cellID, for: indexPath) as? HSFoodCell else {
                    return UICollectionViewCell()
                }
                
                cell.viewModel = foodViewModel
                return cell
            }
            
            return UICollectionViewCell()
        })
        
        menuDiffableDataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            if let cell = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HSFoodCategoriesHeader.cellID, for: indexPath) as? HSFoodCategoriesHeader {
                cell.viewModel = menuViewModel
                return cell
            }
            return nil
        }
    }

}

extension HSMenuCV {
    
    func configureFoodLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .estimated(130)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .estimated(130)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                   heightDimension: .absolute(50)),
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .topLeading)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func configureSaleLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(300),
                                                            heightDimension: .absolute(123)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(300),
                                                                         heightDimension: .absolute(123)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 15, trailing: 16)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    func configureDefaultSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
