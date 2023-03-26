//
//  ServiceListFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

class ServiceListFormatter {
    
    func format(model: ServiceList) -> ServiceListVO {
        let data = model.data.map { service in
            format(model: service)
        }
        
        return ServiceListVO(data: data)
    }
    
    private func format(model: Service) -> ServiceVO {
        let name = model.name
        let imageURL = model.imageURL
        let quantity = model.quantity
        let info = model.info
        let cost = model.cost
        
        return ServiceVO(
            name: name,
            imageURL: imageURL,
            quantity: quantity,
            info: info,
            cost: cost
        )
    }
}
