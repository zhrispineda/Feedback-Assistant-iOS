//
//  ChangeTopicView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct ChangeTopicView: View {
    // Variables
    @Binding var currentFeedback: FeedbackType
    @Environment(\.dismiss) private var dismiss
    let feedbackTypes: [FeedbackType] = [
        FeedbackType(platform: "iOS & iPadOS", subtitle: "iOS & iPadOS features, apps, and devices"),
        FeedbackType(platform: "macOS", subtitle: "macOS features, apps, and devices"),
        FeedbackType(platform: "tvOS", subtitle: "tvOS features, apps, and devices"),
        FeedbackType(platform: "visionOS", subtitle: "visionOS features, apps, and devices"),
        FeedbackType(platform: "watchOS", subtitle: "watchOS features, apps, and devices"),
        FeedbackType(platform: "HomePod", subtitle: "HomePod features, apps, and devices"),
        FeedbackType(platform: "AirPods Beta Firmware", subtitle: "AirPods Beta Firmware features, and devices"),
        FeedbackType(platform: "Developer Technologies & SDKs", subtitle: "APIs and Frameworks for all Apple Platforms"),
        FeedbackType(platform: "Enterprise & Education", subtitle: "MDM, enterprise and education programs and apps, training and certification"),
        FeedbackType(platform: "MFi Technologies", subtitle: "MFi Certification and tools")
    ]
    let feedbackHelper = FeedbackHelper()
    
    
    var body: some View {
        List {
            Section {
                ForEach(feedbackTypes) { type in
                    Button {
                        currentFeedback.platform = type.platform
                        currentFeedback.subtitle = type.subtitle
                        dismiss()
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
