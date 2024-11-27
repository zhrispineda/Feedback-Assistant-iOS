//
//  FeedbackDraftView.swift
//  Feedback Assistant iOS
//
//  Feedback Assistant > New Feedback
//

import SwiftUI

struct FeedbackDraftView: View {
    @Binding var currentFeedback: FeedbackType
    @Environment(\.dismiss) private var dismiss
    @FocusState private var titleFocused: Bool
    @FocusState private var descriptionFocused: Bool
    @State private var title = String()
    @State private var description = String()
    @State private var showingTopicSheet = false
    @State private var showingProblemAreaSheet = false
    let feedbackHelper = FeedbackHelper()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        showingTopicSheet.toggle()
                    } label: {
                        NavigationLink {} label: {
                            VStack(alignment: .leading) {
                                Text(currentFeedback.platform)
                                    .fontWeight(.semibold)
                                Text(currentFeedback.subtitle)
                                    .font(.footnote)
                            }
                        }
                        .foregroundStyle(Color.primary)
                    }
                    .sheet(isPresented: $showingTopicSheet) {
                        NavigationStack {
                            ChangeTopicView(currentFeedback: $currentFeedback)
                        }
                    }
                } header: {
                    Text("Topic")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(.none)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .onAppear {
                    if !currentFeedback.title.isEmpty {
                        title = currentFeedback.title
                        description = currentFeedback.description
                    }
                    if let latestFeedback = feedbackHelper.sortedFeedbacks().first {
                        if latestFeedback.title.isEmpty && latestFeedback.description.isEmpty {
                            currentFeedback = latestFeedback
                        }
                    }
                }
                .onDisappear {
                    if !title.isEmpty {
                        currentFeedback.title = title
                    }
                    if !description.isEmpty {
                        currentFeedback.description = description
                    }
                    currentFeedback.timestamp = Date()
                    feedbackHelper.updateFeedback(currentFeedback)
                    // Cleanup
                    currentFeedback = FeedbackType(platform: "", subtitle: "")
                }
                
                Section {
                    Button {
                        titleFocused = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Please provide a description title for your feedback:")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                                .padding(.bottom, -10)
                            TextEditor(text: $title)
                                .focused($titleFocused)
                                .frame(minHeight: description.isEmpty && !titleFocused ? 40 : nil, alignment: .leading)
                                .padding(.leading, -5)
                                .overlay {
                                    if title.isEmpty && !titleFocused {
                                        Text("Example: Unable to make phone calls from lock screen")
                                            .font(.callout)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundStyle(.tertiary)
                                    }
                                }
                        }
                    }
                    .foregroundStyle(Color.primary)
                    
                    Button {
                        showingProblemAreaSheet.toggle()
                    } label: {
                        NavigationLink {} label: {
                            VStack(alignment: .leading) {
                                Text("Which area are you seeing an issue with?")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                if currentFeedback.productArea == .none {
                                    Text("Please select the problem area")
                                        .font(.callout)
                                        .foregroundStyle(.tertiary)
                                } else {
                                    Text(currentFeedback.productArea.rawValue)
                                        .font(.callout)
                                }
                            }
                        }
                        .foregroundStyle(Color.primary)
                    }
                    .sheet(isPresented: $showingProblemAreaSheet) {
                        ProblemAreaPickerView(currentFeedback: $currentFeedback)
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
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(.none)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                Section {
                    Button {
                        descriptionFocused = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Please describe the issue and what steps we can take to reproduce it:")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                                .padding(.bottom, -10)
                            TextEditor(text: $description)
                                .focused($descriptionFocused)
                                .frame(minHeight: description.isEmpty && !descriptionFocused ? 125 : 60, alignment: .leading)
                                .padding(.leading, -5)
                                .overlay {
                                    if description.isEmpty && !descriptionFocused {
                                        Text("""
                                             Please include:
                                             - A clear description of the problem
                                             - A step-by-step set of instructions to reproduce the problem (if possible)
                                             - What results you expected
                                             - What results you actually saw
                                             """)
                                        .font(.callout)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundStyle(.tertiary)
                                    }
                                }
                        }
                    }
                    .foregroundStyle(Color.primary)
                } header: {
                    Text("Description")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(.none)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                Section {
                    HStack(spacing: 10) {
                        Image(systemName: UIDevice.current.model.lowercased())
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text(UIDevice.current.model)
                                .font(.callout)
                                .fontWeight(.semibold)
                            Text(UIDevice.current.model)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                    NavigationLink("iOS Sysdiagnose", destination: EmptyView())
                        .padding(.leading, 40)
                } header: {
                    Text("Attachments")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(.none)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                    return 40
                }
                
                Section {
                    Button("Add Attachment", systemImage: "paperclip") {}
                } footer: {
                    Text("The device logs gathered by Feedback Assistant may contain personal information. You can tap to view the attached logs before submission, or swipe left to delete.")
                }
            }
            .navigationTitle(currentFeedback.platform)
            .navigationBarTitleDisplayMode(.inline)
            .task {
#if DEBUG
                print("[FeedbackDraftView] Beginning draft form for:\n\(currentFeedback)\n")
#endif
            }
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
    FeedbackDraftView(currentFeedback: .constant(FeedbackType(platform: "Platform", subtitle: "Subtitle")))
}
