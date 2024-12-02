//
//  ProblemAreaPickerView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct ProblemAreaPickerView: View {
    // Variables
    @Binding var currentFeedback: FeedbackType
    @Environment(\.dismiss) private var dismiss
    let pickerType: PickerType
    let typeOptions = ["Incorrect/Unexpected Behavior", "Application Crash", "Application Slow/Unresponsive", "Battery Life", "Suggestion"]
    let occurOptions = ["It's happening right now", "Less than 1 hour ago", "Between 1-6 hours ago", "Between 6-12 hours ago", "Between 12-24 hours ago", "More than 24 hours ago", "I don't know"]
    
    var body: some View {
        NavigationStack {
            List {
                switch pickerType {
                case .productArea:
                    Section {
                        ForEach(ProductArea.allCases, id: \.self) { item in
                            if item != .announcement && item != .none {
                                Button(item.rawValue) {
                                    currentFeedback.productArea = item
                                    dismiss()
                                }
                                .foregroundStyle(Color.primary)
                            }
                        }
                    } header: {
                        Text("Which area are you seeing an issue with?")
                            .textCase(.none)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                    }
                case .productType:
                    Section {
                        ForEach(typeOptions, id: \.self) { item in
                            Button(item) {
                                currentFeedback.productType = item
                                dismiss()
                            }
                            .foregroundStyle(Color.primary)
                        }
                    } header: {
                        Text("Which type of feedback are you reporting?")
                            .textCase(.none)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                    }
                case .lastOccurrence:
                    Section {
                        ForEach(occurOptions, id: \.self) { item in
                            Button(item) {
                                currentFeedback.lastOccurrence = item
                                dismiss()
                            }
                            .foregroundStyle(Color.primary)
                        }
                    } header: {
                        Text("When did the issue last occur?")
                            .textCase(.none)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                    }
                }
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

enum PickerType {
    case productArea, productType, lastOccurrence
}

#Preview {
    ProblemAreaPickerView(currentFeedback: .constant(FeedbackType(platform: "Platform", subtitle: "Subtitle")), pickerType: .lastOccurrence)
}
