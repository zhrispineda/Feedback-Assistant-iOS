//
//  FeedbackNewsView.swift
//  Feedback Assistant iOS
//

import SwiftUI
import WebKit

struct FeedbackNewsView: View {
    let html: String
    let title: String
    
    var body: some View {
        WebView(file: html)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebView: UIViewRepresentable {
    let file: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        if let htmlPath = Bundle.main.path(forResource: file, ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("[WebView] \(file) was not found.")
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    FeedbackNewsView(html: "3416", title: "News")
}
