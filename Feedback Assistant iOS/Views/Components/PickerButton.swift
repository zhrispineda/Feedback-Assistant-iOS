//
//  PickerButton.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct PickerButton: View {
    // Variables
    @State private var showingSheet = false
    @Binding var currentFeedback: FeedbackType
    let pickerType: PickerType
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            NavigationLink {} label: {
                VStack(alignment: .leading) {
                    switch pickerType {
                    case .lastOccurrence:
                        Text("When did the issue last occur?")
                            .font(.callout)
                            .fontWeight(.semibold)
                        if currentFeedback.lastOccurrence.isEmpty {
                            Text("Choose...")
                                .font(.callout)
                                .foregroundStyle(.tertiary)
                        } else {
                            Text(currentFeedback.lastOccurrence)
                                .font(.callout)
                        }
                    case .productType:
                        Text("What type of feedback are you reporting?")
                            .font(.callout)
                            .fontWeight(.semibold)
                        if currentFeedback.productType.isEmpty {
                            Text("Choose...")
                                .font(.callout)
                                .foregroundStyle(.tertiary)
                        } else {
                            Text(currentFeedback.productType)
                                .font(.callout)
                        }
                    case .productArea:
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
            }
            .foregroundStyle(Color.primary)
        }
        .sheet(isPresented: $showingSheet) {
            ProblemAreaPickerView(currentFeedback: $currentFeedback, pickerType: pickerType)
        }
    }
}

#Preview {
    List {
        PickerButton(currentFeedback: .constant(FeedbackType(platform: "", subtitle: "")), pickerType: .productArea)
    }
}
