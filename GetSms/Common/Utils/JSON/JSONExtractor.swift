//
//  JSONExtractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import Foundation

enum JSONExtractor {
    
    private static let decoder = JSONDecoder()
    
    static func extractMap<T: Decodable>(from data: Data) throws -> KeysValues<T>  {
        let jsonString = String(decoding: data, as: UTF8.self)
        let jsonMap = try JSON.parse(string: jsonString)
        let keys = jsonMap.keys!
        let values = try jsonMap.values!.map { value in
            try self.decoder.decode(T.self, from: value.toJSONString().data(using: .utf8)!)
        }
        
        return KeysValues(
            keys: keys,
            values: values
        )
    }
}

struct KeysValues<T> {
    let keys: [String]
    let values: [T]
}
