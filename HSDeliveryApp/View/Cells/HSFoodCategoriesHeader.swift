//
//  HSFoodCategoriesHeader.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class HSFoodCategoriesHeader: UICollectionReusableView {
        
    // MARK: - Parameters
    enum Section {
        case main
    }
    
    private let disposeBag  = DisposeBag()
    static let cellID       = "HSFoodCategoryHeader"
    
    public var viewModel: HSMenuViewModel! { didSet { bind() } }
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var layout: UICollectionViewCompositionalLayout!
    
    // MARK: - Views
    private let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureLayout()
        configureCollectionView()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handle methods
    private func bind() {
        viewModel.foodCategories.subscribe { categories in
            self.updateData(with: categories)
        } onError: { _ in }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe { indexPath in
            self.viewModel.selectedCategory.accept(self.dataSource.itemIdentifier(for: indexPath))
        } onError: { _ in }.disposed(by: disposeBag)
        
        viewModel.selectedCategory.subscribe { category in
            guard let category = category else { return }
            let indexPath = self.dataSource.indexPath(for: category)
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        } onError: { _ in }.disposed(by: disposeBag)

    }
    
    private func updateData(with data: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot)
        }
    }
    
    // MARK: - Configuration
    private func configure() {
        self.backgroundColor = .systemBackground
        
        self.layer.shadowColor      = UIColor.black.cgColor
        self.layer.shadowOpacity    = 0.05
        self.layer.shadowOffset     = CGSize(width: 0, height: 5)
        self.layer.shadowRadius     = 3
    }
    
    private func configureLayout() {
        layout = UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(80), heightDimension: .absolute(40)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            default:
                let group = NSCollectionLayoutGroup(layoutSize: .init(widthDimension: .absolute(1), heightDimension: .absolute(1)))
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            
        })
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, categoryString in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HSCategoryCell.cellID, for: indexPath) as? HSCategoryCell {
                cell.categoryString = categoryString
                return cell
            } else {
                return UICollectionViewCell()
            }
        })
    }
    
    private func configureCollectionView() {
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.register(HSCategoryCell.self, forCellWithReuseIdentifier: HSCategoryCell.cellID)
    }
}
