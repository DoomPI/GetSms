//
//  NumberDataListErrorFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 17.04.2023.
//

class NumberDataListErrorFormatter {
    
    func format(error: Error) -> NumberDataListErrorVO {
        let description = error.localizedDescription
        
        return NumberDataListErrorVO(
            description: description,
            isTemp: false
        )
    }
}
