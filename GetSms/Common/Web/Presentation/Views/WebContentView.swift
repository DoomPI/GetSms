//
//  WebView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import Foundation
import SwiftUI
import WebKit
import UIKit

struct WebContentView: UIViewRepresentable {
    
    @EnvironmentObject var viewModel: WebViewModel
    
    var url: String
    var urlType: URLType
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()

        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = viewModel
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.backgroundColor = UIColor(Color("DarkerBlueColor"))
        return webView
    
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        if urlType == .Local {
            if let localUrl = Bundle.main.url(forResource: url, withExtension: "html", subdirectory: "www") {
                webView.loadFileURL(localUrl, allowingReadAccessTo: localUrl.deletingLastPathComponent())
            }
        } else if urlType == .Public {
            if let requestUrl = URL(string: url) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
}
