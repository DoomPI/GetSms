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
    
    // MARK: - Init
    init(
        processor: any WebProcessorProtocol
    ) {
        self.processor = processor
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
}
