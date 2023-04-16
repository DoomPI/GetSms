//
//  JSONExtractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import Foundation

class JSONExtractor {
    
    // MARK: - Exrernal vars
    public static let shared = JSONExtractor()
    
    // MARK: - Internal vars
    private let decoder = JSONDecoder()
    
    // MARK: - Init
    private init() {}
    
    func extractMap<T: Decodable>(from data: Data) throws -> KeysValues<T>  {
        let jsonString = String(decoding: data, as: UTF8.self)
        let jsonMap = try JSON.parse(string: jsonString)
        guard
            let keys = jsonMap.keys,
            let values = jsonMap.values
        else {
            throw NSError(domain: "JSONExtractor", code: 1)
        }
        let decodedValues = try values.map { value in
            guard
                let data = value.toJSONString().data(using: .utf8)
            else {
                throw NSError(domain: "JSONExtractor", code: 1)
            }
            return try self.decoder.decode(T.self, from: data)
        }
        
        return KeysValues(
            keys: keys,
            values: decodedValues
        )
    }
}

struct KeysValues<T> {
    let keys: [String]
    let values: [T]
}
