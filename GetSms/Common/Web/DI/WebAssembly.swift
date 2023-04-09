//
//  WebAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

enum WebAssembly {
    
    static func assemble() -> WebViewModel {
        
        let processor = WebProcessor()
        let reducer = WebReducer()
        
        let viewModel = WebViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
