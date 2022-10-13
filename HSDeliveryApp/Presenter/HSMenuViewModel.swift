//
//  HSMenuViewModel.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import Foundation
import RxSwift

class HSMenuViewModel {
    
    // MARK: -
    private let disposeBag = DisposeBag()
    
    public var food: BehaviorSubject<[HSFoodViewModel]> = .init(value: [])
    
    // MARK: -
    public func fetchFood() {
        let networkManager = NetworkManager()
        
        DispatchQueue.global().async {
            networkManager.fetchData(ofType: [Food].self,
                                     from: "https://raw.githubusercontent.com/IvanPuzanov/FoodDeliveryAPI/main/HSFoodDelivery.json")
            .map { $0.map { HSFoodViewModel(food: $0) }}
            .subscribe { food in
                self.food.onNext(food)
            } onError: { _ in }.disposed(by: self.disposeBag)
        }
    }
}
