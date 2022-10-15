//
//  HSMenuViewModel.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import Foundation
import RxSwift
import RxRelay

class HSMenuViewModel {
    
    // MARK: -
    private let disposeBag = DisposeBag()
    
    public var sales: BehaviorSubject<[HSSaleViewModel]> = .init(value: [])
    public var food: BehaviorSubject<[HSFoodViewModel]> = .init(value: [])
    public var foodCategories: BehaviorRelay<[String]> = .init(value: [])
    
    public var selectedCategory: BehaviorRelay<String?> = .init(value: "pizza")
    
    // MARK: -
    public func fetchFood() {
        let networkManager = NetworkManager()
        
        DispatchQueue.global().async {
            networkManager.fetchData(ofType: [Food].self,
                                     from: "https://raw.githubusercontent.com/IvanPuzanov/FoodDeliveryAPI/main/HSFoodDelivery.json")
            .map { $0.map {HSFoodViewModel(food: $0)} }
            .subscribe { food in
                self.food.onNext(food)
                self.filterByCategories(with: food)
            } onError: { _ in }.disposed(by: self.disposeBag)
            
            networkManager.fetchData(ofType: [Sale].self,
                                     from: "https://raw.githubusercontent.com/IvanPuzanov/FoodDeliveryAPI/main/HSSales.json")
            .map { $0.map {HSSaleViewModel(sale: $0)} }
            .subscribe { sales in
                self.sales.onNext(sales)
            } onError: { _ in }.disposed(by: self.disposeBag)

        }
    }
    
    public func createSnaphot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        do {
            let sales   = try sales.value()
            let food    = try food.value()
            
            if !sales.isEmpty {
                switch snapshot.sectionIdentifiers.contains(.food) {
                case true:
                    snapshot.insertSections([.sale], beforeSection: .food)
                case false:
                    snapshot.appendSections([.sale])
                }
                snapshot.appendItems(sales, toSection: .sale)
            }
            if !food.isEmpty {
                snapshot.appendSections([.food])
                snapshot.appendItems(food, toSection: .food)
            }
        } catch { }
        
        return snapshot
    }
    
    private func filterByCategories(with food: [HSFoodViewModel]) {
        var categories = [String]()
        
        food.forEach { foodItem in
            guard !categories.contains(foodItem.category) else { return }
            categories.append(foodItem.category)
        }

        self.foodCategories.accept(categories)
    }
    
    public func getItemForSelectedCategory() -> HSFoodViewModel? {
        do {
            let food = try self.food.value()
            return food.first(where: {
                guard let category = selectedCategory.value else { return false }
                return $0.category == category
            })
        } catch {
            return nil
        }
    }
}
