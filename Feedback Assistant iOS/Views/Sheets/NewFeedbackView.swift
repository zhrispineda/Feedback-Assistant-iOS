//
//  NewFeedbackView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct NewFeedbackView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    let feedbackTypes: [FeedbackType] = [
        FeedbackType(platform: "iOS & iPadOS", description: "iOS & iPadOS features, apps, and devices"),
        FeedbackType(platform: "macOS", description: "macOS features, apps, and devices"),
        FeedbackType(platform: "tvOS", description: "tvOS features, apps, and devices"),
        FeedbackType(platform: "visionOS", description: "visionOS features, apps, and devices"),
        FeedbackType(platform: "watchOS", description: "watchOS features, apps, and devices"),
        FeedbackType(platform: "HomePod", description: "HomePod features, apps, and devices"),
        FeedbackType(platform: "AirPods Beta Firmware", description: "AirPods Beta Firmware features, and devices"),
        FeedbackType(platform: "Developer Technologies & SDKs", description: "APIs and Frameworks for all Apple Platforms"),
        FeedbackType(platform: "Enterprise & Education", description: "MDM, enterprise and education programs and apps, training and certification"),
        FeedbackType(platform: "MFi Technologies", description: "MFi Certification and tools")
    ]
        
    
    var body: some View {
        List {
            Section {
                ForEach(feedbackTypes) { type in
                    Button {} label: {
                        NewFeedbackType(title: type.platform, subtitle: type.description)
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

struct FeedbackType: Identifiable {
    var id = UUID()
    var platform = String()
    var description = String()
    
    init(platform: String, description: String) {
        self.platform = platform
        self.description = description
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
        NewFeedbackView()
    }
}
