//
//  CacheWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation
import RxSwift

struct CacheWorker {
    
    static let shared = CacheWorker()
    
    // MARK: - Init
    private init() {}
    
    func write(to path: URL, data: Data) -> Completable {
        return Completable.create { subscriber in
            do {
                try data.write(to: path)
                subscriber(CompletableEvent.completed)
            } catch {
                subscriber(CompletableEvent.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func read(from path: URL) -> Single<Data?> {
        return Single<Data?>.create { subscriber in
            do {
                let file = try FileHandle(forReadingFrom: path)
                subscriber(SingleEvent.success(file.availableData))
            } catch {
                subscriber(SingleEvent.success(nil))
            }
            
            return Disposables.create()
        }
    }
}
