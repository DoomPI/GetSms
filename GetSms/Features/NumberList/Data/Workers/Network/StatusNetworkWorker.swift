//
//  StatusNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.04.2023.
//

import RxSwift
import Foundation

protocol StatusNetworkWorkingLogic {
    
    func setStatus(numberId: String, setStatusNetworkDto: SetStatusNetworkDTO) -> Single<GetStatusNetworkDTO>
}

class StatusNetworkWorker {
    
    // MARK: - Internal vars
    private static let worker = NetworkWorker.shared
    private static let decoder = JSONDecoder()
    
    private static let keychainWorker = KeychainWorker.shared
    
    private static let statusUrl = "https://vak-sms.com/api/setStatus/"
    private static let apiKeyQueryItemName = "apiKey"
    private static let statusQueryItemName = "status"
    private static let idNumQueryItemName = "idNum"
}

extension StatusNetworkWorker: StatusNetworkWorkingLogic {
    
    func setStatus(numberId: String, setStatusNetworkDto: SetStatusNetworkDTO) -> Single<GetStatusNetworkDTO> {
        getApiKey().flatMap { apiKey in
            Single.deferred {
                let queryItems = [
                    URLQueryItem(
                        name: Self.apiKeyQueryItemName,
                        value: apiKey.apiKey
                    ),
                    URLQueryItem(
                        name: Self.statusQueryItemName,
                        value: setStatusNetworkDto.status
                    ),
                    URLQueryItem(
                        name: Self.idNumQueryItemName,
                        value: numberId
                    ),
                ]
                var urlComps = URLComponents(string: Self.statusUrl)
                urlComps?.queryItems = queryItems
                guard let url = urlComps?.url else {
                    throw NSError(domain: "StatusNetworkWorker", code: 1)
                }
                
                return Self.worker.sendRequest(
                    url: url
                ).map { data in
                    try Self.decoder.decode(GetStatusNetworkDTO.self, from: data)
                }
            }
        }
    }
    
    private func getApiKey() -> Single<ApiKey> {
        return Self.keychainWorker.getApiKey()
    }
}

