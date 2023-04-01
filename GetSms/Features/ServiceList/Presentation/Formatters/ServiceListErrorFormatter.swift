//
//  ServiceListErrorFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

class ServiceListErrorFormatter {
    
    func format(error: Error) -> ServiceListErrorVO {
        return ServiceListErrorVO(description: error.localizedDescription)
    }
}
