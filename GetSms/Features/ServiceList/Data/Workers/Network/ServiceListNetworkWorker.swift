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
    private let serviceListUrl = URL(string: "https://vak-sms.com/api/getCountNumbersList/")!
}

extension ServiceListNetworkWorker: ServiceListNetworkWorkingLogic {
    
    func getServiceList() -> Single<ServiceListNetworkDTO> {
        return worker.sendRequest(url: serviceListUrl).map { data in
            return try self.decoder.decode(
                ServiceListNetworkDTO.self,
                from: data
            )
        }
    }
}
