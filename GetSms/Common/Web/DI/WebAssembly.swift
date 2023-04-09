//
//  WebAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

enum WebAssembly {
    
    static func assemble() -> WebViewModel {
        
        let processor = WebProcessor()
        
        let viewModel = WebViewModel(
            processor: processor
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
