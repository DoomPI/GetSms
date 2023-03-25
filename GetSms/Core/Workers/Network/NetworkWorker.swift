//
//  NetworkWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import Foundation

class NetworkWorker {
    
    // MARK: - Shared
    static let shared = NetworkWorker()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Internal vars
    private let session = URLSession.shared
}

extension NetworkWorker: NetworkWorking {

    func sendRequest(
        to url: URL,
        params: [String: String]?,
        completion: @escaping (Data?) -> Void
    ) async {
        return await Task {
            session.dataTask(with: url) { data, response, error in
                if let data {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                } else {
                    print("Could not get any content")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
        }.value
    }
}

