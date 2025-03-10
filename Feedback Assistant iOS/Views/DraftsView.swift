//
//  DraftsView.swift
//  Feedback Assistant iOS
//
//  Feedback Assistant > Drafts
//

import SwiftUI

struct DraftsView: View {
    // Variables
    @EnvironmentObject var stateManager: StateManager
    @State private var searchText = String()
    @State private var filterEnabled = false
    @State private var feedbacks: [FeedbackType] = []
    let table = "CommonStrings"
    let feedbackHelper = FeedbackHelper()
    
    var filteredFeedbacks: [FeedbackType] {
        if searchText.isEmpty {
            return feedbacks
        } else {
            return feedbacks.filter { feedback in
                feedback.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredFeedbacks) { feedback in
                if UIDevice.current.userInterfaceIdiom == .phone {
                    NavigationLink {
                        FeedbackReadDraftView(feedback: feedback)
                    } label: {
                        FeedbackLabel(feedback: feedback)
                    }
                } else {
                    Button {
                        stateManager.id = feedback.id
                        stateManager.destination = AnyView(FeedbackReadDraftView(feedback: feedback))
                    } label: {
                        FeedbackLabel(feedback: feedback)
                    }
                    .listRowBackground(stateManager.id == feedback.id ? Color("Selected") : nil)
                }
            }
            .onDelete { indexSet in
                feedbackHelper.deleteFeedback(at: indexSet)
                feedbacks = feedbackHelper.sortedFeedbacks()
            }
        }
        .listStyle(.inset)
        .onAppear {
            feedbacks = feedbackHelper.sortedFeedbacks()
            stateManager.id = UUID()
            stateManager.destination = AnyView(NoFeedbackView())
        }
        .navigationBarItems(trailing: EditButton())
        .navigationTitle("DRAFTS_INBOX")
        .refreshable {
            feedbacks = feedbackHelper.sortedFeedbacks()
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                ZStack {
                    HStack {
                        Button {
                            withAnimation {
                                filterEnabled.toggle()
                            }
                        } label: {
                            Image(systemName: filterEnabled ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .imageScale(.large)
                        }
                        Spacer()
                        NewFeedbackButton()
                    }
                    if filterEnabled {
                        VStack(spacing: -5) {
                            Text("FILTERED_BY_PROMPT", tableName: table)
                                .font(.subheadline)
                            Button("FILTER_OPEN".localize(table: table)) {}
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DraftsView()
    }
}
