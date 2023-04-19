//
//  NetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import Foundation
import RxSwift

class NetworkWorker {
    
    // MARK: - Shared
    static let shared = NetworkWorker()
    
    // MARK: - Init
    private init() {}
    
    // MARK: Public methods
    func sendRequest(url: URL) -> Single<Data> {
        return Single<Data>.create { subscriber in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    subscriber(SingleEvent.success(data))
                } else if let error {
                    subscriber(SingleEvent.failure(error))
                } else {
                    subscriber(SingleEvent.failure(NSError(domain: "NetworkWorker", code: 1)))
                }
            }.resume()
            return Disposables.create()
        }
    }
}
