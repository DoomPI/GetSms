//
//  WebAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

import WebKit

enum WebAssembly {
    
    static func assemble(
        didFinish: @escaping (WKWebView) -> Void
    ) -> WebViewModel {
        
        let processor = WebProcessor()
        
        let viewModel = WebViewModel(
            processor: processor,
            didFinish: didFinish
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
