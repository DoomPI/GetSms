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
    
    // MARK: - Internal vars
    private let processor: any WebProcessorProtocol
    private var webView: WKWebView? = nil
    
    private let didCommit: (WKWebView) -> Void
    private let didFinish: (WKWebView) -> Void
    private let decidePolicyFor: (WKWebView, WKNavigationAction, @escaping (WKNavigationActionPolicy) -> Void) -> Void
    
    // MARK: - Init
    init(
        processor: any WebProcessorProtocol,
        didCommit: @escaping (WKWebView) -> Void,
        didFinish: @escaping (WKWebView) -> Void,
        decidePolicyFor: @escaping (WKWebView, WKNavigationAction, @escaping (WKNavigationActionPolicy) -> Void) -> Void
    ) {
        self.processor = processor
        self.didCommit = didCommit
        self.didFinish = didFinish
        self.decidePolicyFor = decidePolicyFor
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
                webView.goForward()
            }
            
        case .Backward:
            guard let webView else { return }
            if webView.canGoBack {
                webView.goBack()
            }
            
        case .Reload:
            guard let webView else { return }
            webView.reload()
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
        print(error)
    }
}
