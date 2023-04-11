//
//  AuthViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import WebKit
import SwiftUI

protocol AuthHandlerProtocol: Handler where Intent == AuthIntent {
}

class AuthViewModel: ObservableObject {
    
    // MARK: - External state
    @Published private(set) var state: AuthState = .Idle
    
    // MARK: - Internal vars
    private let urlLk = "https://vak-sms.com/lk/"
    private let processor: any AuthProcessorProtocol
    private let reducer: any AuthReducerProtocol
    
    // MARK: - Init
    init(
        processor: any AuthProcessorProtocol,
        reducer: any AuthReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func webViewDidFinish(webView : WKWebView) {
        if webView.url?.absoluteString == urlLk {
            webView.evaluateJavaScript(authScript, in: nil, in: .defaultClient) { [weak self] result in
                guard let self else { return }
                switch result {
                    case .success(let value):
                        if let apiKeyString = value as? String {
                            self.processor.fireIntent(intent: .SaveApiKey(apiKey: ApiKey(apiKey: apiKeyString)))
                        }
                                
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    func webViewDecidePolicyFor(webView: WKWebView) {
        if webView.url?.absoluteString == urlLk {
            webView.isHidden = true
            processor.fireIntent(intent: .BlockingLoad)
        }
    }
}

extension AuthViewModel: AuthHandlerProtocol {
    
    func handle(intent: Intent) {
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
    }
}
