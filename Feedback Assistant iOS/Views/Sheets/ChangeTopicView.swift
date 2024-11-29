//
//  ChangeTopicView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct ChangeTopicView: View {
    // Variables
    @Binding var currentFeedback: FeedbackType
    @Environment(\.dismiss) private var dismiss
    let feedbackHelper = FeedbackHelper()
    
    var body: some View {
        List {
            Section {
                ForEach(feedbackHelper.feedbackTypes) { type in
                    Button {
                        currentFeedback.platform = type.platform
                        currentFeedback.subtitle = type.subtitle
                        dismiss()
                    } label: {
                        HStack {
                            NewFeedbackType(title: type.platform, subtitle: type.subtitle)
                            Spacer()
                            if currentFeedback.platform == type.platform {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.accent)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            } header: {
                Text("MULTIPLE_FORMS_PICK_ONE_FEEDBACK").textCase(.none)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Topic")
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

#Preview {
    NavigationStack {
        ChangeTopicView(currentFeedback: .constant(FeedbackType(platform: "Platform", subtitle: "Subtitle")))
    }
}
