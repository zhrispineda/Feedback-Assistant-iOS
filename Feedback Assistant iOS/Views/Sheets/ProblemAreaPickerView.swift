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
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                            .textCase(nil)
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
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                            .textCase(nil)
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
    case productArea, productType
}

#Preview {
    ProblemAreaPickerView(currentFeedback: .constant(FeedbackType(platform: "Platform", subtitle: "Subtitle")), pickerType: .productType)
}
