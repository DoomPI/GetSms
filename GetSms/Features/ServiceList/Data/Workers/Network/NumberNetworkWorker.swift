//
//  NumberListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation
import RxSwift

protocol NumberNetworkWorkingLogic {
    
    func getNumber(apiKey: String, serviceCode: String, countryCode: String) -> Single<NumberNetworkDTO>
}

class NumberNetworkWorker {
    
    // MARK: - Internal vars
    private static let worker = NetworkWorker.shared
    private static let decoder = JSONDecoder()
    
    private static let numberListUrl = "https://vak-sms.com/api/getNumber/"
    private static let apiKeyQueryItemName = "apiKey"
    private static let serviceQueryItemName = "service"
    private static let countryQueryItemName = "country"
}

extension NumberNetworkWorker: NumberNetworkWorkingLogic {
    
    func getNumber(apiKey: String, serviceCode: String, countryCode: String) -> Single<NumberNetworkDTO> {
        Single.deferred {
            let queryItems = [
                URLQueryItem(
                    name: Self.apiKeyQueryItemName,
                    value: apiKey
                ),
                URLQueryItem(
                    name: Self.serviceQueryItemName,
                    value: serviceCode
                ),
                URLQueryItem(
                    name: Self.countryQueryItemName,
                    value: countryCode
                )
            ]
            var urlComps = URLComponents(string: Self.numberListUrl)!
            urlComps.queryItems = queryItems
            
            return Self.worker.sendRequest(
                url: urlComps.url!
            ).map { data in
                try Self.decoder.decode(NumberNetworkDTO.self, from: data)
            }
        }
    }
}
