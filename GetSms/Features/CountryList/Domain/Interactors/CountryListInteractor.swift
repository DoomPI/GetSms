//
//  CountryListInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import Foundation
import RxSwift

protocol CountryListBusinessLogic {
    
    func getCountryList() -> Single<CountryList>
}

class CountryListInteractor {
    
    // MARK: - Internal vars
    private let networkWorker: CountryListNetworkWorker
    private let networkMapper: CountryListNetworkMapper
    
    // MARK: - Init
    init(
        networkWorker: CountryListNetworkWorker,
        networkMapper: CountryListNetworkMapper
    ) {
        self.networkWorker = networkWorker
        self.networkMapper = networkMapper
    }
}

extension CountryListInteractor: CountryListBusinessLogic {
    
    func getCountryList() -> Single<CountryList> {
        return networkWorker.getCountryList().map { dto in
            self.networkMapper.fromDto(dto: dto)
        }
    }
}
