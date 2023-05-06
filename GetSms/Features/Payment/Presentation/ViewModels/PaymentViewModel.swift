//
//  PaymentViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

import SwiftUI
import WebKit

protocol PaymentHandlerProtocol: Handler where Intent == PaymentIntent {
}

class PaymentViewModel: ObservableObject {
    
    typealias State = PaymentState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Idle
    
    // MARK: - Internal vars
    private let urlMain = "https://vak-sms.com/"
    private let urlPayment = "https://vak-sms.com/pay/"
    private let processor: any PaymentProcessorProtocol
    private let reducer: any PaymentReducerProtocol
    
    // MARK: - Init
    init(
        processor: any PaymentProcessorProtocol,
        reducer: any PaymentReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func openPayment() {
        processor.fireIntent(intent: .Open)
    }
    
    func closePayment() {
        processor.fireIntent(intent: .Close)
    }
    
    func webViewDidCommit(webView: WKWebView) {
        webView.evaluateJavaScript(hideComponets)
    }
    
    func webViewDidFinish(webView: WKWebView) {
    }
    
    func webViewDecidePolicyFor ( _ webView: WKWebView,
     decidePolicyFor navigationAction: WKNavigationAction,
     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
 ) {
        let str = navigationAction.request.url?.absoluteString
        if (str == urlMain){
            return decisionHandler(.cancel)
        }
        return decisionHandler(.allow)
    }
}

extension PaymentViewModel: PaymentHandlerProtocol {
    
    func handle(intent: Intent) {
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
    }
}
