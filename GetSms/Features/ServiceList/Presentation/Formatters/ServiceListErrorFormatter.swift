//
//  ServiceListErrorFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

class ServiceListErrorFormatter {
    
    func format(error: Error) -> ServiceListErrorVO {
        var description = error.localizedDescription
        if (error is PurchaseNumberError) {
            description = (error as! PurchaseNumberError).localizedDescription
            return ServiceListErrorVO(description: description, isTemp: true)
        }
        return ServiceListErrorVO(description: description, isTemp: false)
    }
}
