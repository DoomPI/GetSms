//
//  ServiceListFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

class ServiceListFormatter {
    
    func format(model: ServiceList) -> ServiceListVO {
        let services = model.services.map { service in
            format(model: service)
        }
        
        return ServiceListVO(services: services)
    }
    
    private func format(model: Service) -> ServiceVO {
        let code = model.code
        let name = model.name
        let imageURL = model.imageURL
        let quantity = String(format: "%d шт.", model.quantity)
        let cost = String(format: "%.2f₽", model.cost)
        let backgroundColorRes = model.isLowQuantity
        ? "RedColor"
        : "GreenColor"
        
        return ServiceVO(
            code: code,
            name: name,
            imageURL: imageURL,
            quantity: quantity,
            cost: cost,
            backgroundColorRes: backgroundColorRes
        )
    }
}
