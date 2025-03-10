//
//  FeedbackNewsLabel.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct FeedbackNewsLabel: View {
    var feedback: FeedbackType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 3) {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(feedback.status == .attention ? .accent : .clear)
                        .font(.caption2)
                    Text(feedback.title.isEmpty ? "Untitled Feedback" : feedback.title)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(feedback.timestampText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text("News – \(feedback.platform)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.leading, 15)
            }
        }
    }
}
