//
//  FeedbackDraftView.swift
//  Feedback Assistant iOS
//
//  Feedback Assistant > New Feedback
//

import SwiftUI

struct FeedbackDraftView: View {
    @AppStorage("feedbacks") private var feedbackData: Data = Data()
    @Environment(\.dismiss) private var dismiss
    @State private var newFeedbackData = FeedbackType(platform: "", subtitle: "")
    @State private var title = String()
    @State private var description = String()
    let fbData = FBData()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {} label: {
                        NavigationLink {} label: {
                            VStack(alignment: .leading) {
                                Text(newFeedbackData.platform)
                                    .fontWeight(.semibold)
                                Text(newFeedbackData.subtitle)
                                    .font(.footnote)
                            }
                        }
                        .foregroundStyle(Color.primary)
                    }
                } header: {
                    Text("Topic")
                        .fontWeight(.semibold)
                        .textCase(.none)
                }
                .onAppear {
                    if let latestFeedback = fbData.sortedFeedbacks().first {
                        newFeedbackData = latestFeedback
                    }
                }
                .onDisappear {
                    if !title.isEmpty {
                        newFeedbackData.title = title
                    }
                    if !description.isEmpty {
                        newFeedbackData.description = description
                    }
                    fbData.updateFeedback(newFeedbackData)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Please provide a description title for your feedback:")
                            .font(.callout)
                            .fontWeight(.semibold)
                        TextField("", text: $title, prompt: Text("Example: Unable to make phone calls from lock screen"))
                            .autocapitalization(.none)
                    }
                    Button {} label: {
                        NavigationLink {} label: {
                            VStack(alignment: .leading) {
                                Text("Which area are you seeing an issue with?")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                Text("Please select the problem area")
                                    .font(.callout)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .foregroundStyle(Color.primary)
                    }
                    Button {} label: {
                        NavigationLink {} label: {
                            VStack(alignment: .leading) {
                                Text("What type of feedback are you reporting?")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                Text("Choose...")
                                    .font(.callout)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .foregroundStyle(Color.primary)
                    }
                } header: {
                    Text("Basic Information")
                        .fontWeight(.semibold)
                        .textCase(.none)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Please describe the issue and what steps we can take to reproduce it:")
                            .font(.callout)
                            .fontWeight(.semibold)
                        TextField("", text: $description, prompt: Text("Please include:"))
                            .autocapitalization(.none)
                    }
                } header: {
                    Text("Description")
                        .fontWeight(.semibold)
                        .textCase(.none)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text(UIDevice.current.model)
                            .font(.callout)
                            .fontWeight(.semibold)
                        Text(UIDevice.current.model)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    NavigationLink("\(UIDevice.current.systemName) Sysdiagnose", destination: EmptyView())
                } header: {
                    Text("Attachments")
                        .fontWeight(.semibold)
                        .textCase(.none)
                }
                
                Section {
                    Button("Add Attachment", systemImage: "paperclip") {}
                } footer: {
                    Text("The device logs gathered by Feedback Assistant may contain personal information. You can tap to view the attached logs before submission, or swipe left to delete.")
                }
            }
            .navigationTitle(newFeedbackData.platform)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Submit") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FeedbackDraftView()
}
