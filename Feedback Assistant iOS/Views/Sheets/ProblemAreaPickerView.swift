//
//  ProblemAreaPickerView.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct ProblemAreaPickerView: View {
    // Variables
    @Binding var currentFeedback: FeedbackType
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(ProductArea.allCases, id: \.self) { item in
                        if item != .announcement {
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

#Preview {
    ProblemAreaPickerView(currentFeedback: .constant(FeedbackType(platform: "Platform", subtitle: "Subtitle")))
}
