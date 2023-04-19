//
//  NumberListFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

class NumberDataListFormatter {
    
    func format(model: NumberDataList) -> NumberDataListVO {
        let numbers = model.data.map { number in
            format(model: number)
        }
        
        return NumberDataListVO(
            numbers: numbers
        )
    }
    
    private func format(model: NumberData) -> NumberDataVO {
        let number = format(model: model.number)
        let smsList = model.smsList
        let backgroundColorRes = model.smsList.data.isEmpty
        ? "YellowColor"
        : "GreenColor"
        
        return NumberDataVO(
            number: number,
            smsList: smsList,
            backgroundColorRes: backgroundColorRes
        )
    }
    
    private func format(model: Number) -> NumberVO {
        let serviceName = model.serviceName
        let id = model.id
        let number = "+\(model.phoneNumber)"
        
        return NumberVO(
            serviceName: serviceName,
            id: id,
            number: number
        )
    }
}
