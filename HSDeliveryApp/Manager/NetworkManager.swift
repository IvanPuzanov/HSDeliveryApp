//
//  NetworkManager.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 13.10.2022.
//

import Foundation
import RxSwift

class NetworkManager: NSObject {
    
    /// Fetching data from API
    /// - Parameters:
    ///   - ofType: Codable model type
    ///   - url: Source link
    /// - Returns: Observable data of passed type
    public func fetchData<T: Codable>(ofType: T.Type, from url: String) -> Observable<T> {
        return Observable.create { observer in
            guard let url = URL(string: url) else {
                return Disposables.create()
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: url)
                let decodedData = try decoder.decode(T.self, from: data)
                
                observer.onNext(decodedData)
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
