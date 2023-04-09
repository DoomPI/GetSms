//
//  AuthViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import WebKit
import SwiftUI

class AuthViewModel: ObservableObject {
    
    let URL_LK = "https://vak-sms.com/lk/"
    let SCRIPT = "(function() { return (document.getElementsByClassName('sidebar')[0].getAttribute('data-api')); })();"
    
    func webViewDidFinish(webView : WKWebView){
        if (webView.url?.absoluteString == URL_LK){
            webView.evaluateJavaScript(SCRIPT, in: nil, in: .defaultClient) { result  in
                switch result {
                    case .success(let value):
                        if let apiKeyString = value as? String {
                            let apiKey = ApiKey(apiKey: apiKeyString)
                            // Сохранение в KeyChain
                            KeychainHelper.standard.save(apiKey, service: apiKeyService, account: account)
                            // Чтение из KeyChain
                            if let receivedData = KeychainHelper.standard.read(service: apiKeyService, account: account){
                                do {
                                    let apiKK = try  JSONDecoder().decode(ApiKey.self, from: receivedData)
                                    print(apiKK.apiKey+"!")
                                    
                                } catch {}
                            
                            }
                        }
                                
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
                    
        }
    }
    
}
