//
//  WebViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

import Foundation
import SwiftUI
import WebKit

protocol WebHandlerProtocol: Handler where Intent == WebIntent {
}

class WebViewModel: NSObject, ObservableObject {
    
    @Published private(set) var errorState: ErrorState = .None
    
    // MARK: - Internal vars
    private let processor: any WebProcessorProtocol
    private var webView: WKWebView? = nil
    
    private let didCommit: (WKWebView) -> Void
    private let didFinish: (WKWebView) -> Void
    private let decidePolicyFor: (WKWebView, WKNavigationAction, @escaping (WKNavigationActionPolicy) -> Void) -> Void
    private let didFail: (String) -> Void
    
    // MARK: - Init
    init(
        processor: any WebProcessorProtocol,
        didCommit: @escaping (WKWebView) -> Void,
        didFinish: @escaping (WKWebView) -> Void,
        decidePolicyFor: @escaping (WKWebView, WKNavigationAction, @escaping (WKNavigationActionPolicy) -> Void) -> Void,
        didFail: @escaping (String) -> Void
    ) {
        self.processor = processor
        self.didCommit = didCommit
        self.didFinish = didFinish
        self.decidePolicyFor = decidePolicyFor
        self.didFail = didFail
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func forward() {
        processor.fireIntent(intent: .Forward)
    }
    
    func backward() {
        processor.fireIntent(intent: .Backward)
    }
    
    func reload() {
        processor.fireIntent(intent: .Reload)
    }
}

extension WebViewModel: WebHandlerProtocol {
    
    func handle(intent: Intent) {
        
        switch intent {
            
        case .None:
            break
            
        case .Forward:
            guard let webView else { return }
            if webView.canGoForward {
                errorState = .None
                webView.goForward()
            }
            
        case .Backward:
            guard let webView else { return }
            if webView.canGoBack {
                errorState = .None
                webView.goBack()
            }
            
        case .Reload:
            guard let webView else { return }
            errorState = .None
            webView.reload()
            
        case .Error(message: let message):
            guard let webView else { return }
            errorState = .InfError(message: message)
        }
        
    }
}

extension WebViewModel: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webView = webView
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinish(webView)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        didCommit(webView)
    }

    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        return decidePolicyFor(webView, navigationAction, decisionHandler)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let nsError = error as NSError
        if nsError.code != -999 {
            processor.fireIntent(intent: .Error(message: error.localizedDescription))
        }
        didFail(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError error: Error){
        let nsError = error as NSError
        if nsError.code != -999 {
            processor.fireIntent(intent: .Error(message: error.localizedDescription))
        }
        didFail(error.localizedDescription)
    }
}
