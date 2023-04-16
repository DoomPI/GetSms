//
//  SmsListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation
import RxSwift

protocol SmsListNetworkWorkingLogic {
    
    func getSmsList(apiKey: String, numberId: String) -> Single<SmsListNetworkDTO>
}

class SmsListNetworkWorker {
    
    // MARK: - Internal vars
    private static let worker = NetworkWorker.shared
    private static let decoder = JSONDecoder()
    
    private static let keychainWorker = KeychainWorker.shared
    
    private static let smsListUrl = "https://vak-sms.com/api/getSmsCode/"
    private static let apiKeyQueryItemName = "apiKey"
    private static let idNumQueryName = "idNum"
    private static let allQueryName = "all"
}

extension SmsListNetworkWorker: SmsListNetworkWorkingLogic {
    
    func getSmsList(apiKey: String, numberId: String) -> Single<SmsListNetworkDTO> {
        Single.deferred {
            let queryItems = [
                URLQueryItem(
                    name: Self.apiKeyQueryItemName,
                    value: apiKey
                ),
                URLQueryItem(
                    name: Self.idNumQueryName,
                    value: numberId
                ),
                URLQueryItem(
                    name: Self.allQueryName,
                    value: nil
                )
            ]
            var urlComps = URLComponents(string: Self.smsListUrl)!
            urlComps.queryItems = queryItems
            
            return Self.worker.sendRequest(
                url: urlComps.url!
            ).map { data in
                try Self.decoder.decode(SmsListNetworkDTO.self, from: data)
            }
        }
    }
    
    func getApiKey() -> Single<ApiKey> {
        return Self.keychainWorker.getApiKey()
    }
}
