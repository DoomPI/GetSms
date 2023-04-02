//
//  ServiceListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift
import Foundation

protocol ServiceListNetworkWorkingLogic {
    
    func getServiceList(countryCode: String) -> Single<ServiceListNetworkDTO>
}

class ServiceListNetworkWorker {
    
    // MARK: - Internal vars
    private static let worker = NetworkWorker.shared
    private static let extractor = JSONExtractor.shared
    
    private static let serviceListUrl = "https://vak-sms.com/api/getCountNumbersList/"
    private static let countryQueryItemName = "country"
}

extension ServiceListNetworkWorker: ServiceListNetworkWorkingLogic {
    
    func getServiceList(countryCode: String) -> Single<ServiceListNetworkDTO>{
        Single.deferred {
            let queryItems = [
                URLQueryItem(
                    name: Self.countryQueryItemName,
                    value: countryCode
                )
            ]
            var urlComps = URLComponents(string: Self.serviceListUrl)!
            urlComps.queryItems = queryItems
            
            return Self.worker.sendRequest(
                url: urlComps.url!
            ).map { data in
                try Self.extractor.extractMap(from: data)
            }
        }
    }
}
