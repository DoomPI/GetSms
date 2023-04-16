//
//  NumberListInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import RxSwift

protocol NumberListBusinessLogic {
    
    func getNumberList() -> Single<NumberDataList>
}

class NumberListInteractor {
    
    // MARK: - Internal vars
    
    private let smsListNetworkWorker: SmsListNetworkWorkingLogic
    private let smsListNetworkMapper: SmsListNetworkMapper
    
    private let numberCacheWorker: NumberCacheWorkingLogic
    private let numberCacheMapper: NumberCacheMapper
    
    // MARK: - Init
    init(
        smsListNetworkWorker: SmsListNetworkWorkingLogic,
        smsListNetworkMapper: SmsListNetworkMapper,
        numberCacheWorker: NumberCacheWorkingLogic,
        numberCacheMapper: NumberCacheMapper
    ) {
        self.smsListNetworkWorker = smsListNetworkWorker
        self.smsListNetworkMapper = smsListNetworkMapper
        self.numberCacheWorker = numberCacheWorker
        self.numberCacheMapper = numberCacheMapper
    }
}

extension NumberListInteractor: NumberListBusinessLogic {
    
    func getNumberList() -> Single<NumberDataList> {
        return getNumbersFromCache().flatMap { numbers in
            Observable.from(
                numbers.map { number in
                    self.getNumberData(number: number)
                        .asObservable()
                }
            )
            .merge()
            .toArray()
        }
        .flatMap { numberData in
            self.setNumbersInCache(numbers: numberData.map { $0.number})
                .andThen(Single.just(NumberDataList(data: numberData)))
        }
    }
    
    private func getNumberData(number: Number) -> Maybe<NumberData> {
        return getSmsListFromNetwork(numberId: number.id)
            .catchAndReturn(SmsList.empty)
            .filter { $0 != SmsList.empty }
            .map { smsList in
                NumberData(number: number, smsList: smsList)
            }
    }
    
    private func getSmsListFromNetwork(numberId: String) -> Single<SmsList> {
        return self.smsListNetworkWorker.getSmsList(numberId: numberId).map { dto in
            return try self.smsListNetworkMapper.fromDto(dto: dto)
        }
    }
    
    private func getNumbersFromCache() -> Single<[Number]> {
        return numberCacheWorker.getNumbers().map { dto in
            try self.numberCacheMapper.fromDto(dto: dto)
        }
    }
    
    private func setNumbersInCache(numbers: [Number]) -> Completable {
        Completable.deferred {
            let dto = self.numberCacheMapper.toDto(model: numbers)
            return self.numberCacheWorker.setNumbers(numbers: dto)
        }
    }
}
