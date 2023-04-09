//
//  AuthViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import WebKit
import SwiftUI
import RxSwift

protocol AuthHandlerProtocol: Handler where Intent == AuthIntent {
}

class AuthViewModel: ObservableObject {
    
    // MARK: - External state
    @Published var state: AuthState = .Idle
    
    // MARK: - Internal vars
    private let urlLk = "https://vak-sms.com/lk/"
    private let processor: any AuthProcessorProtocol
    private let reducer: any AuthReducerProtocol
    private let interacor: AuthBusinessLogic
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(
        processor: any AuthProcessorProtocol,
        reducer: any AuthReducerProtocol,
        interactor: AuthBusinessLogic
    ) {
        self.processor = processor
        self.reducer = reducer
        self.interacor = interactor
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func webViewDidFinish(webView : WKWebView) {
        if webView.url?.absoluteString == urlLk {
            webView.evaluateJavaScript(authScript, in: nil, in: .defaultClient) { [weak self] result in
                switch result {
                    case .success(let value):
                        if let apiKeyString = value as? String {
                            let apiKey = ApiKey(apiKey: apiKeyString)
                            self?.saveToKeyChain(apiKey: apiKey)
                            self?.success(model: AuthModel(apiKey: apiKeyString))
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
    
    private func saveToKeyChain(apiKey: ApiKey) {
        interacor.saveToKeyChain(apiKey: apiKey)
    }
    
    private func success(model: AuthModel) {
        processor.fireIntent(intent: .Success(model: model))
    }
}

extension AuthViewModel: AuthHandlerProtocol {
    
    func handle(intent: Intent) {
        let newState = self.reducer.reduce(currentState: state, intent: intent)
        self.state = newState
    }
}
