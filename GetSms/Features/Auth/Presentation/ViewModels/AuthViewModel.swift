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
    @Published private(set) var errorState: ErrorState = .None
    
    // MARK: - Internal vars
    private let urlMain = "https://vak-sms.com/"
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
    
    func didCommit(webView : WKWebView) {
        webView.evaluateJavaScript(hideAuthComponets)
    }
    
    func webViewDidFail(message: String){
        processor.fireIntent(intent: .Error(message: message))
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
    
    func webViewDecidePolicyFor ( _ webView: WKWebView,
     decidePolicyFor navigationAction: WKNavigationAction,
     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
 ) {
         let str = navigationAction.request.url?.absoluteString
         if (str == urlMain){
             return decisionHandler(.cancel)
         }
         if webView.url?.absoluteString == urlLk {
             webView.isHidden = true
             processor.fireIntent(intent: .BlockingLoad)
         }
         return decisionHandler(.allow)
     }
 }

extension AuthViewModel: AuthHandlerProtocol {
    
    func handle(intent: Intent) {
        switch intent {
            case .Error(let message):
                self.errorState = .Error(message: message)
            default:
                self.errorState = .None
        }
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
    }
}
