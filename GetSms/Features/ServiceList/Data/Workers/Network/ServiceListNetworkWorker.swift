//
//  ServiceListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift
import Foundation

protocol ServiceListNetworkWorkingLogic {
    
    func getServiceList() -> Single<[ServiceNetworkDTO]>
}

class ServiceListNetworkWorker {
    
    // MARK: - Internal vars
    private let worker = NetworkWorker.shared
    private let decoder = JSONDecoder()
    
    private let serviceListUrl = "https://vak-sms.com/api/getCountNumbersList/"
    private let countryQueryItemName = "country"
    
    private let countryListUrl = "https://vak-sms.com/api/getCountryOperatorList/"
}

extension ServiceListNetworkWorker: ServiceListNetworkWorkingLogic {
    
    func getServiceList() -> Single<[ServiceNetworkDTO]>{
        Single.deferred { [weak self] in
            guard let self else { throw NetworkError.IrrelevantRequest }
            let queryItems = [URLQueryItem(name: self.countryQueryItemName, value: "ru")]
            var urlComps = URLComponents(string: self.serviceListUrl)!
            urlComps.queryItems = queryItems
            
            return self.worker.sendRequest(
                url: urlComps.url!
            ).map { data in
                let values = try JSON.parse(string: String(decoding: data, as: UTF8.self)).values!
                return try values.map { value in
                    try self.decoder.decode([ServiceNetworkDTO].self, from: value.toJSONString().data(using: .utf8)!)[0]
                }
            }
        }
    }
}

enum NetworkError: Error {
case IrrelevantRequest
}
