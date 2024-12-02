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
    @State private var showingCancelAlert = false
    @State private var title = String()
    @State private var description = String()
    @State private var showingTopicSheet = false
    @State private var showingIncompleteAlert = false
    @State private var incompleteCheck = false
    let feedbackHelper = FeedbackHelper()
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: Topic section
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
                } header: {
                    Text("Topic")
                        .sectionHeaderStyle()
                }
                
                // MARK: Basic Information section
                Section {
                    Button {
                        titleFocused = true
                    } label: {
                        HStack(spacing: 5) {
                            if incompleteCheck && title.isEmpty {
                                Image(systemName: "arrow.forward.circle.fill")
                                    .foregroundStyle(.red)
                                    .fontWeight(.heavy)
                                    .padding(.leading, -10)
                            }
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
                                            Text(getTitleExample())
                                                .font(.callout)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(.tertiary)
                                        }
                                    }
                                    .onChange(of: title) { // Prevent new lines
                                        title = title.replacingOccurrences(of: "\n", with: "")
                                        incompleteCheck = false
                                    }
                            }
                        }
                    }
                    .foregroundStyle(Color.primary)
                    
                    HStack {
                        if incompleteCheck && currentFeedback.productArea == .none {
                            Image(systemName: "arrow.forward.circle.fill")
                                .foregroundStyle(.red)
                                .fontWeight(.heavy)
                                .padding(.leading, -10)
                        }
                        PickerButton(currentFeedback: $currentFeedback, pickerType: .productArea)
                    }
                    PickerButton(currentFeedback: $currentFeedback, pickerType: .productType)
                } header: {
                    Text("Basic Information")
                        .sectionHeaderStyle()
                }
                
                // MARK: Details section
                if currentFeedback.platform == "visionOS" {
                    Section {
                        PickerButton(currentFeedback: $currentFeedback, pickerType: .lastOccurrence)
                    } header: {
                        Text("Details")
                            .sectionHeaderStyle()
                    }
                }
                
                // MARK: Description section
                Section {
                    Button {
                        descriptionFocused = true
                    } label: {
                        HStack {
                            if incompleteCheck && description.isEmpty {
                                Image(systemName: "arrow.forward.circle.fill")
                                    .foregroundStyle(.red)
                                    .fontWeight(.heavy)
                                    .padding(.leading, -10)
                            }
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
                    }
                    .foregroundStyle(Color.primary)
                    
                    if currentFeedback.platform == "HomePod" {
                        PickerButton(currentFeedback: $currentFeedback, pickerType: .lastOccurrence)
                    }
                } header: {
                    Text("Description")
                        .sectionHeaderStyle()
                }
                
                if currentFeedback.platform == "iOS & iPadOS" {
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
                            .sectionHeaderStyle()
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { ViewDimensions in
                        return 40
                    }
                }
                
                Section {
                    Button("Add Attachment", systemImage: "paperclip") {}
                } footer: {
                    Text("The device logs gathered by Feedback Assistant may contain personal information. You can tap to view the attached logs before submission, or swipe left to delete.")
                }
            }
            .alert("Do you want to save the current draft?", isPresented: $showingCancelAlert) {
                Button("Delete Draft", role: .destructive) {
                    feedbackHelper.deleteFeedbackById(withId: currentFeedback.id)
                    dismiss()
                }
                Button("Save Draft") {
                    if !title.isEmpty {
                        currentFeedback.title = title
                    }
                    if !description.isEmpty {
                        currentFeedback.description = description
                    }
                    currentFeedback.timestamp = Date()
                    feedbackHelper.updateFeedback(currentFeedback)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }
            .alert("Missing Answers", isPresented: $showingIncompleteAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Review your feedback report and fill in any missing answers.")
            }
            .onAppear {
#if DEBUG
                print("[FeedbackDraftView] Beginning draft form for:\n\(currentFeedback)\n")
#endif
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
                // Cleanup
                currentFeedback = FeedbackType(platform: "", subtitle: "")
            }
            .navigationTitle(currentFeedback.platform)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingTopicSheet) {
                NavigationStack {
                    ChangeTopicView(currentFeedback: $currentFeedback)
                }
            }
            .toolbar {
                // Display Done if focused on a TextEditor
                if titleFocused || descriptionFocused {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            titleFocused = false
                            descriptionFocused = false
                        }
                        .fontWeight(.semibold)
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            showingCancelAlert.toggle()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Submit") {
                            if title.isEmpty {
                                incompleteCheck = true
                                showingIncompleteAlert.toggle()
                            } else {
                                dismiss()
                            }
                        }
                        .disabled(incompleteCheck)
                    }
                }
            }
        }
    }
    
    // MARK: Functions
    private func getTitleExample() -> String {
        switch currentFeedback.platform {
        case "iOS & iPadOS", "visionOS":
            return "Example: Unable to make phone calls from lock screen"
        case "macOS":
            return "Example: Calendar events are missing after creating an event"
        case "tvOS":
            return "Example: Movie titles are displayed in a foreign language"
        case "watchOS":
            return "Example: Activity tracker is missing recent work outs"
        case "HomePod", "AirPods Beta Firmware":
            return "Provide details..."
        case "Developer Technologies & SDKs", "Enterprise & Education":
            return "Example: Core Data should support nil values as defaults"
        case "Developer Tools & Resources":
            return "Example: Xcode crashes when using autocomplete"
        case "MFi Technologies":
            return "Example: ATS is incorrectly parsing HID Report"
        default:
            return String()
        }
    }
}

#Preview {
    FeedbackDraftView(currentFeedback: .constant(FeedbackType(platform: "visionOS", subtitle: "Subtitle")))
}
