//
//  NewFeedbackView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct NewFeedbackView: View {
    // Variables
    @State private var newFeedbackData = FeedbackType(platform: "", subtitle: "")
    @Environment(\.dismiss) private var dismiss
    @Binding var showingNewFeedbackInfo: Bool
    let feedbackHelper = FeedbackHelper()
    
    var body: some View {
        List {
            Section {
                ForEach(feedbackHelper.feedbackTypes) { type in
                    Button {
                        dismiss()
                        newFeedbackData = type
                        feedbackHelper.saveFeedbackDraft(newFeedbackData)
                        showingNewFeedbackInfo.toggle()
                    } label: {
                        NewFeedbackType(title: type.platform, subtitle: type.subtitle)
                    }
                    .foregroundStyle(.primary)
                }
            } header: {
                Text("MULTIPLE_FORMS_PICK_ONE_FEEDBACK").textCase(.none)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("New Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color(UIColor.systemGray), Color(UIColor.systemGray4))
                        .font(.title2)
                }
            }
        }
    }
}

struct NewFeedbackType: View {
    var title = String()
    var subtitle = String()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .fontWeight(.medium)
                Text(subtitle)
                    .font(.footnote)
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        NewFeedbackView(showingNewFeedbackInfo: .constant(false))
    }
}
