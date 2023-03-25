//
//  NetworkWorking.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

protocol NetworkWorking {

    func sendRequest(
        to url: URL,
        params: [String: String]?,
        completion: @escaping (Data?) -> Void
    ) async
}
