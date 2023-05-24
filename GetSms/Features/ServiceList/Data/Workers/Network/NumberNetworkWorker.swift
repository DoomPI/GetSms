//
//  NumberListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation
import RxSwift

protocol NumberNetworkWorkingLogic {
    
    func getNumber(apiKey: String, serviceCode: String, countryCode: String) -> Single<Result<NumberNetworkDTO, PurchaseNumberError>>
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
    
    func getNumber(apiKey: String, serviceCode: String, countryCode: String) -> Single<Result<NumberNetworkDTO, PurchaseNumberError>> {
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
            var urlComps = URLComponents(string: Self.numberListUrl)
            urlComps?.queryItems = queryItems
            guard let url = urlComps?.url else {
                throw NSError(domain: "NumberNetworkWorker", code: 1)
            }
            
            return Self.worker.sendRequest(
                url: url
            ).map { data in
                
                if let result = try? Self.decoder.decode(NumberNetworkDTO.self, from: data) {
                    return .success(result)
                }
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                return .failure(getPurchaseNumberError(from: json))
            }
        }
    }
}
