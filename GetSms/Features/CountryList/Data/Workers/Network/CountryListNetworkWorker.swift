//
//  CountryListNetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import Foundation
import RxSwift

protocol CountryListNetworkWorkingLogic {
    
    func getCountryList() -> Single<CountryListNetworkDTO>
}

class CountryListNetworkWorker {
    
    // MARK: - Internal vars
    private static let worker = NetworkWorker.shared
    private static let extractor = JSONExtractor.shared
    
    private static let countryListUrl = "https://vak-sms.com/api/getCountryOperatorList/"
}

extension CountryListNetworkWorker: CountryListNetworkWorkingLogic {
    
    func getCountryList() -> Single<CountryListNetworkDTO>{
        Single.deferred {
            let queryItems: [URLQueryItem] = []
            var urlComps = URLComponents(string: Self.countryListUrl)
            urlComps?.queryItems = queryItems
            guard let url = urlComps?.url else {
                throw NSError(domain: "CountryListNetworkWorker", code: 1)
            }
            
            return Self.worker.sendRequest(
                url: url
            ).map { data in
                try Self.extractor.extractMap(from: data)
            }
        }
    }
}
