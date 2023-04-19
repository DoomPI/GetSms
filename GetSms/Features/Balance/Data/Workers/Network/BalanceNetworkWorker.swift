//
//  BalanceNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import Foundation
import RxSwift

protocol BalanceNetworkWorkingLogic {
    
    func getBalance(apiKey: String) -> Single<BalanceNetworkDTO>
}

class BalanceNetworkWorker {
    
    // MARK: - Internal vars
    private static let worker = NetworkWorker.shared
    private let decoder = JSONDecoder()
    
    private static let balanceUrl = "https://vak-sms.com/api/getBalance/"
    private static let apiKeyQueryItemName = "apiKey"
}

extension BalanceNetworkWorker: BalanceNetworkWorkingLogic {
    
    func getBalance(apiKey: String) -> Single<BalanceNetworkDTO> {
        Single.deferred {
            let queryItems = [
                URLQueryItem(
                    name: Self.apiKeyQueryItemName,
                    value: apiKey
                )
            ]
            var urlComps = URLComponents(string: Self.balanceUrl)
            urlComps?.queryItems = queryItems
            guard let url = urlComps?.url else {
                throw NSError(domain: "BalanceNetworkWorker", code: 1)
            }
            
            return Self.worker.sendRequest(
                url: url
            ).map { data in
                try self.decoder.decode(BalanceNetworkDTO.self, from: data)
            }
        }
    }
}
