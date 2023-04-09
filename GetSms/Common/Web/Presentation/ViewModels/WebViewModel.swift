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
    
    typealias State = WebState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Idle
    
    // MARK: - Internal vars
    private let processor: any WebProcessorProtocol
    private let reducer: any WebReducerProtocol
    
    // MARK: - Init
    init(
        processor: any WebProcessorProtocol,
        reducer: any WebReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
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
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
    }
}

extension WebViewModel: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        switch state {
            
        case .Idle:
            break
            
        case .PresentForward:
            if webView.canGoForward {
                webView.goForward()
            }
            
        case .PresentBackward:
            if webView.canGoBack {
                webView.goBack()
            }
            
        case .PresentReload:
            webView.reload()

        }
    }
}
