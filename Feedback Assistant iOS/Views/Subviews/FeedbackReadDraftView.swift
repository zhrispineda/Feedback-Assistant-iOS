//
//  FeedbackReadDraftView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct FeedbackReadDraftView: View {
    var feedback: FeedbackType
    @State private var currentFeedback = FeedbackType(platform: "Empty", subtitle: "empty")
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading) {
                    Text(feedback.title)
                        .font(.headline)
                        .padding(.bottom, 8)
                    Divider()
                    Text("BASIC INFORMATION")
                        .padding(.bottom, 5)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("Please provide a descriptive title for your feedback:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(feedback.title + "\n")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Which area are you seeing an issue with?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("No answer provided\n")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("What type of feedback are you reporting?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("No answer provided\n")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Divider()
                    Text("DESCRIPTION")
                        .padding(.bottom, 5)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("Please describe the issue and what steps we can take to reproduce it:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(feedback.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .contentMargins(.top, 0)
            .listStyle(.grouped)
            .navigationTitle(feedback.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("", systemImage: "ellipsis.circle") {
                        Button("Edit Draft", systemImage: "bubble.and.pencil") {}
                        Button("Delete Draft", systemImage: "trash", role: .destructive) {}
                    }
                }
            }
        }
    }
}

#Preview {
    FeedbackReadDraftView(feedback: FeedbackType(platform: "Platform", subtitle: "Subtitle"))
}
