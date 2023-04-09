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
                        if let apiKey = value as? String {
                            print(apiKey)
                        }
                                
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
                    
        }
    }
    
}
