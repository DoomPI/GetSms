//
//  NumberListCacheDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation
import RxSwift

protocol NumberCacheWorkingLogic {
    
    func getNumbers() -> Single<[NumberCacheDTO]>
    
    func setNumbers(numbers: [NumberCacheDTO]) -> Completable
}

class NumberCacheWorker {
    
    // MARK: - Internal vars
    private static let cacheWorker = CacheWorker.shared
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    private static let numberListPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("numbers.json")
}

extension NumberCacheWorker: NumberCacheWorkingLogic {
    
    func getNumbers() -> Single<[NumberCacheDTO]> {
        Self.cacheWorker.read(from: Self.numberListPath).map { data in
            guard let data else { return [] }
            return try Self.decoder.decode([NumberCacheDTO].self, from: data)
        }
    }
    
    func setNumbers(numbers: [NumberCacheDTO]) -> Completable {
        Completable.deferred {
            let data = try Self.encoder.encode(numbers)
            return Self.cacheWorker.write(to: Self.numberListPath, data: data)
        }
    }
}
