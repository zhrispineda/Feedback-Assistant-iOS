//
//  FeedbackLabel.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct FeedbackLabel: View {
    var feedback: FeedbackType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(feedback.title.isEmpty ? "Untitled Feedback" : feedback.title)
                        .font(.headline)
                    Spacer()
                    Text(feedback.timestampText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text("Feedback Draft – \(feedback.platform)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}
