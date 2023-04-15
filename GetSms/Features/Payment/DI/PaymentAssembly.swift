//
//  PaymentAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

enum PaymentAssembly {
    
    static func assemble() -> PaymentViewModel {
        
        let processor = PaymentProcessor()
        let reducer = PaymentReducer()
        
        let viewModel = PaymentViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
