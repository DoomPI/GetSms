//
//  NumberListInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import RxSwift
import Foundation

protocol NumberListBusinessLogic {
    
    func getNumberList() -> Single<NumberDataList>
    
    func setStatus(numberSetStatus: NumberSetStatus) -> Single<NumberGetStatus>
}

class NumberListInteractor {
    
    // MARK: - Internal vars
    
    private let smsListNetworkWorker: SmsListNetworkWorkingLogic
    private let smsListNetworkMapper: SmsListNetworkMapper
    
    private let numberCacheWorker: NumberCacheWorkingLogic
    private let numberCacheMapper: NumberCacheMapper
    
    private let statusNetworkWorker: StatusNetworkWorkingLogic
    private let statusNetworkMapper: StatusNetworkMapper
    
    // MARK: - Init
    init(
        smsListNetworkWorker: SmsListNetworkWorkingLogic,
        smsListNetworkMapper: SmsListNetworkMapper,
        numberCacheWorker: NumberCacheWorkingLogic,
        numberCacheMapper: NumberCacheMapper,
        statusNetworkWorker: StatusNetworkWorkingLogic,
        statusNetworkMapper: StatusNetworkMapper
    ) {
        self.smsListNetworkWorker = smsListNetworkWorker
        self.smsListNetworkMapper = smsListNetworkMapper
        self.numberCacheWorker = numberCacheWorker
        self.numberCacheMapper = numberCacheMapper
        self.statusNetworkWorker = statusNetworkWorker
        self.statusNetworkMapper = statusNetworkMapper
    }
}

extension NumberListInteractor: NumberListBusinessLogic {
    
    func getNumberList() -> Single<NumberDataList> {
        return getNumbersFromCache().flatMap { numbers in
            Observable.from(
                numbers.map { number in
                    self.getNumberData(number: number)
                }
            )
            .merge()
            .toArray()
        }
        .flatMap { numberData in
            return self.setNumbersInCache(numbers: numberData.map { $0.number})
                .andThen(Single.just(NumberDataList(data: numberData)))
        }
    }
    
    func setStatus(numberSetStatus: NumberSetStatus) -> Single<NumberGetStatus> {
        setStatusInNetwork(numberSetStatus: numberSetStatus).map { dto in
            try self.statusNetworkMapper.fromDto(dto: dto)
        }.flatMap { getStatus in
            self.getNumbersFromCache().flatMap { numbers in
                let newNumbers = numbers.filter { $0.id != numberSetStatus.numberId }
                return self.setNumbersInCache(numbers: newNumbers)
                    .andThen(Single.just(NumberGetStatus(
                        numberId: numberSetStatus.numberId,
                        status: getStatus
                    )))
            }
        }
    }
    
    private func getNumberData(number: Number) -> Maybe<NumberData> {
        return getSmsListFromNetwork(numberId: number.id).map { smsList in
            NumberData(number: number, smsList: smsList)
        }
    }
    
    private func getSmsListFromNetwork(numberId: String) -> Maybe<SmsList> {
        self.smsListNetworkWorker.getSmsList(numberId: numberId).flatMapMaybe { dto in
            do {
                let smsList = try self.smsListNetworkMapper.fromDto(dto: dto)
                return Maybe.just(smsList)
            } catch {
                return Maybe.empty()
            }
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
    
    private func setStatusInNetwork(numberSetStatus: NumberSetStatus) -> Single<GetStatusNetworkDTO> {
        Single.deferred {
            let setStatusNetworkDto = self.statusNetworkMapper.toDto(model: numberSetStatus.status)
            
            return self.statusNetworkWorker.setStatus(
                numberId: numberSetStatus.numberId,
                setStatusNetworkDto: setStatusNetworkDto
            )
        }
    }
}
