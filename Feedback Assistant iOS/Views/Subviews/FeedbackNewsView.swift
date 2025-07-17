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
        if let htmlPath = Bundle.main.path(forResource: html, ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            WebView(url: url)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        }

    }
}

#Preview {
    FeedbackNewsView(html: "3416", title: "News")
        .environment(StateManager())
}
