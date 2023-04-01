//
//  ServiceListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift
import Foundation

protocol ServiceListNetworkWorkingLogic {
    
    func getServiceList() -> Single<ServiceListNetworkDTO>
}

class ServiceListNetworkWorker {
    
    // MARK: - Internal vars
    private let worker = NetworkWorker.shared
    private let decoder = JSONDecoder()
    
    private let serviceListUrl = "https://vak-sms.com/api/getCountNumbersList/"
    private let countryQueryItemName = "country"
}

extension ServiceListNetworkWorker: ServiceListNetworkWorkingLogic {
    
    func getServiceList() -> Single<ServiceListNetworkDTO>{
        Single.deferred { [weak self] in
            guard let self else { throw NetworkError.IrrelevantRequest }
            let queryItems = [URLQueryItem(name: self.countryQueryItemName, value: "ru")]
            var urlComps = URLComponents(string: self.serviceListUrl)!
            urlComps.queryItems = queryItems
            
            return self.worker.sendRequest(
                url: urlComps.url!
            ).map { data in
                try JSONExtractor.extractMap(from: data)
            }
        }
    }
}

enum NetworkError: Error {
case IrrelevantRequest
}
