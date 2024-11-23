//
//  NewFeedbackView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct NewFeedbackView: View {
    // Variables
    @AppStorage("feedbacks") private var feedbackData: Data = Data()
    @State private var newFeedbackData = FeedbackType(platform: "", subtitle: "")
    @Environment(\.dismiss) private var dismiss
    @Binding var showingNewFeedbackInfo: Bool
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
    let fbData = FBData()
    
    
    var body: some View {
        List {
            Section {
                ForEach(feedbackTypes) { type in
                    Button {
                        dismiss()
                        newFeedbackData = type
                        fbData.saveFeedbackDraft(newFeedbackData)
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
                        .font(.title)
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
