//
//  WebAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

import WebKit

enum WebAssembly {
    
    static func assemble(
        didCommit: @escaping (WKWebView)->Void,
        didFinish: @escaping (WKWebView) -> Void,
        decidePolicyFor: @escaping (WKWebView, WKNavigationAction, @escaping (WKNavigationActionPolicy) -> Void) -> Void,
        didFail: @escaping (String) -> Void
    ) -> WebViewModel {
        
        let processor = WebProcessor()
        
        let viewModel = WebViewModel(
            processor: processor,
            didCommit: didCommit,
            didFinish: didFinish,
            decidePolicyFor: decidePolicyFor,
            didFail: didFail
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
