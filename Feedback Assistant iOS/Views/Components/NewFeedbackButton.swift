//
//  NewFeedbackButton.swift
//  Feedback Assistant iOS
//

import SwiftUI

struct NewFeedbackButton: View {
    // Variables
    @State private var feedbackDraft = FeedbackType(platform: "", subtitle: "")
    @State private var showingNewFeedbackButtonPopover = false
    @State private var showingNewFeedbackView = false
    
    var body: some View {
        Button {
            showingNewFeedbackButtonPopover.toggle()
        } label: {
            Image(systemName: "bubble.and.pencil")
                .imageScale(.large)
        }
        .sheet(isPresented: $showingNewFeedbackView) {
            FeedbackDraftView(currentFeedback: $feedbackDraft)
        }
        .popover(isPresented: $showingNewFeedbackButtonPopover, attachmentAnchor: .point(.center), arrowEdge: .bottom) {
            NavigationStack {
                NewFeedbackView(showingNewFeedbackInfo: $showingNewFeedbackView)
            }
            .frame(width: UIDevice.current.model.contains("iPad") ? 350 : nil, height: UIDevice.current.model.contains("iPad") ? 400 : nil)
        }
    }
}

#Preview {
    NewFeedbackButton()
}
